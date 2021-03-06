---
layout: post
title: Lazy evaluation with PHP
author: Juozas
email: juozas@juokaz.com
date: 2011-05-31 15:07:14
tags: [php, haskell, lazy evaluation, strict evaluation, mysql, out of memory]
categories:
- PHP
- Data
- Databases
---

Recently I needed to process a huge array of data and because of PHP’s somewhat inefficient variables and especially arrays that was resulting in "out of memory" errors. However, I couldn't use any other tools than PHP so was forced to come up with a solution implementation in it. Here is how I solved it using principles from functional languages.

<!--more-->

<blockquote>
In programming language theory, lazy evaluation or call-by-need is an evaluation strategy which delays the evaluation of an expression until its value is actually required (non-strict evaluation) and also avoid repeated evaluations (sharing). The sharing can reduce the running time of certain functions by an exponential factor over other non-strict evaluation strategies, such as call-by-name.
</blockquote>

What you are about to read is not necessary about gaining extra performance, most of the times it’s going to stay the same, goal of this is to minimize memory usage as much as possible. So if you have a million of rows to process each weighting 10kb, the memory usage always stays at around 10kb. *Theoretically, PHP is not that perfect at cleaning up memory.*

### The problem

Let’s image that you need to process those million database records, how are you going to do it? Well, obviously the first step is to fetch them from a database. **Stop!** I can’t even remember how many times I’ve seen people making mistakes here… Why? Eager evaluation, lookup this term. Wait, I'm going to make sure you know what I'm talking about so read it [here](http://en.wikipedia.org/wiki/Eager_evaluation) in Wikipedia.

All comes down to using [`fetchAll()`](http://php.net/manual/en/pdostatement.fetchall.php) method - the script was fetching all orders in a specified time range from a database. What `fetchAll()` does is returns an array with all results matching the query, but this requires quite some memory if amount of results is in thousands. Later the script was doing some calculations and creating a second results array now with processed data. At the end of the main loop memory usage was `row count * size per row * 2`, a very big number.

It’s very rarely beneficial to do it like this - most of the time data can be processed per row, removing the need to store everything in memory. Sometimes SQL queries won’t allow it, but even those can be changed to make it possible to abandon pre-computation and work with data as streams. Once you have a data stream, you can start working with it using pipelines.

### Functional languages

<div class="alignright" ><img src="/media/haskell.jpg" alt="Haskell logo" class="noborder"></div>

Before looking at PHP solutions for this problem, let's analyse how it can be done in a functional language. Image a function returning all [Fibonacci numbers](http://en.wikipedia.org/wiki/Fibonacci_number), here is an implementation in Haskell (from Haskell [documentation](http://www.haskell.org/haskellwiki/Haskell/Lazy_evaluation)):

{% highlight haskell %}
magic :: Int -> Int -> [Int]
magic 0 _ = []
magic m n = m: (magic n (m+n))
{% endhighlight %}

By calling it with `magic 1 1` it will return a list `[1,1,2,3,5,8,…]`. But the important part is that this list or the return value is *infinite*. There is no boundary like "return 100 numbers", it will actually return all possible numbers. You might say that’s impossible and you are kind-of right, especially if you haven’t worked with similar functional languages before.

Because Haskell uses lazy evaluation (with strict being an option), calling this method doesn’t actually compute anything.  Instead it creates a generator-like resource from which you can read as many numbers as you want, and as long as you are reading them it’s computing next one. So with a function like:

{% highlight haskell %}
getIt :: [Int] -> Int -> Int
getIt [] _ = 0
getIt (x:xs) 1 = x
getIt (x:xs) n = getIt xs (n-1)
{% endhighlight %}

We can get *Xth* number of Fibonacci - call it like `getIt (magic 1 1) 5` and output should be 5, because the 5th number of the sequence is 5. Important part here is that even though I’m passing a result of function `magic` to the `getIt` function, as mentioned above, `magic` doesn’t need to compute anything to return. `getIt` reads 5 numbers from that infinite list and terminates returning the last number.

### PHP way

Sadly, you can’t really do anything like that easily in PHP, because it doesn’t support lazy evaluation or [generators](http://wiki.python.org/moin/Generators). However it’s possible to improvise and have a working solution. And the solution is… [`Iterators`](http://php.net/manual/en/class.iterator.php). One of the most underused functionality in PHP.

Any class which extends an `Iterator` can be used in `foreach` as a data source. Let me give you a short example of an iterator generating all numbers from 0 to infinity:

<div class="alignright" ><img src="/media/lazy.gif" alt="Lazy" class="noborder"></div>

{% highlight php linenos %}
﻿<?php
class Numbers implements Iterator
{
    private $position = 0;
    
    function rewind() {
        $this->position = 0;
    }
    function current() {
        return $this->position;
    }
    function key() {
        return $this->position;
    }
    function next() {
        ++$this->position;
    }
    function valid() {
        return true;
    }
}

$n = new Numbers;

foreach($n as $value) {
    print $value . PHP_EOL;
}

{% endhighlight %}

Running this script will yield a never-ending list of numbers. But you can only do 10 iterations and get 10th number all without ever needing to store whole sequence in memory. Of course this is going to be slower than just calculating 10, but using similar approach you can process data one atomic unit per cycle without ever storing it in memory. 

If you need to render data in a view again remember the memory - do not compute the result in a model (or god forbid controller) and then pass it to a view. Creating an iterator in model and return it for consumption in a view. For view it is the same thing - array and iterator are both iteratable, but you are saving a lot of otherwise wasted memory. 

### Database side

Aggregation *should* always happen in database side, when possible. So if you need a total of all items sold for each order - calculate that using a `SUM()` function rather than doing it when iterating over results. Because to do it you need to look back or forward in results set, and that breaks lazy evaluation immediately. 

First of all, fetch data with a normal `fetch()` method in a `while` loop, rather that iterating over `fetchAll()` result. Nothing will break, hopefully, but instead of building array of all results and then processing them, the script will process each row and release it from memory. MySQL returns a cursor to results’ set and PHP driver will use that to get each row after row.

You might wonder how to render pages like a list of orders with items. It’s quite easy, just join orders' and items' tables and order results by `order id`. The data you will be getting back will look something like this

{% highlight php %}
Order ID   Item ID   Item name
1          156       Milk
1          897       Bread
2          156       Milk
{% endhighlight %}

To render this just iterate over results and as soon as `order id` changes from previous one, start a new HTML table for an order. Using this approach you can render whole history of all orders with information about items too without ever using more memory that one row size. The only limiting factor is then response HTML size.

### Conclusion

Obviously PHP wasn’t really created for anything like this, but situations when you need to make it work happen. Make sure you are not building up any data or fetching it eagerly and release resources as soon as you are done. This solved all the problems for me and all of the sudden same script was processing all the data without any memory leaks.
