---
layout: post
title: Never trust your sources
author: Juozas
email: juozas@juokaz.com
date: 2011-08-25 13:27:00
tags: [php, validation, edinburgh festival, import]
categories:
- PHP
- Security
---

Data validation sounds like an obvious thing and it appears that everyone is doing it, but here are some ideas on where you might be doing it wrong. It's not a practical examples article though, I'd assume they are pretty easy to figure out; this is more about implications and causes of various different validation errors. All of them are where we had suffered before, so make sure not to repeat the same mistakes.

<!--more-->

This post is not about security, although security is probably one of the most important users of validation. Here I'd like to talk about other uses cases of validation, mainly being how to make sense of data you are receiving and make sure it's not breaking your applications.

### Obvious rules

<div class="alignright" ><img src="/media/rules.gif" alt="Rules" class="noborder"></div>

If you expect an integer, check if it's an integer. If you expect a date, check if it's date. It doesn't matter if it is an admin interface and

> "only ourselves will be using it, so we will be always entering valid data"

This is not [phpMyAdmin](http://www.phpmyadmin.net/home_page/index.php) you are building (even that is actually validating what you have entered before storing in a database), making sure there is no way to mess up the database from any app will save you time. And grey hair.

More than once have I seen the cases of applications not checking what they are accepting as a price of a product and then failing to render any successive screens because math operations on it are invalid. It's especially bad when users can't fix it themselves and need to contact you, the developer, to handle that from the other end. If I enter *1'000'000'000* to stock quantity field make sure the whole app doesn't explode trying to insert so many rows in a database. 

### Make assumptions

Programming, I believe, is about logic. So don't be an *idiot* and use some of it. Ask questions about the input you are receiving, be it user entered data or auto-imports from external sources, and lock down the expectations. Here are some basic rules, just examples of course, sounding so natural, but still I rarely see them in practice:

<div class="alignleft" ><img src="/media/assume.jpg" alt="Make assumptions" class="noborder"></div>

* Product price larger than 0, smaller than 1000
* Person's age is between 0 and 150
* Stock quantity is between 0 and 50
* Order cannot have date in the feature
* Etc.

Obviously it depends on the application you are building and these might change, but most likely they won't and allowing arbitrary data to be entered can create huge problems. This is better than the [Blacklist](http://en.wikipedia.org/wiki/Blacklist) approach which is not really pratical, as it requires specifying what your data **can't be** rather what it **can only be**.

If you are importing data from an external source, does it make sense for the result to be empty? If it's a list of events it cannot be empty, unless the whole thing got cancelled. So discard such an import and log that you got 0 events, and you expected at least a dozen… do not delete all events from your database. That is - do not trust the source 100%, use your, or code's, head too. 

### Structure

<div class="alignleft" ><img src="/media/structure.png" alt="Structure" class="noborder"></div>

This one is so easy to check it's not even funny when your data imports go wrong.  It can be an Excel spread sheet, some custom format or XML serialized data. All of those have structure, which you should be able to rely on. Personally, if data format changes, I make sure that my code would just stop processing it immediately, because it doesn't know any more what any of it means.

For tabular data it's very easy to check tables' headers - the amount of them and their labels. The order can change, you can figure out how to handle this, but if some fields are missing it is indicating that possibly the actual data can be mixed up to. XML might be trickier to check as it has nested structures, but one could use validation against a [DTD](http://en.wikipedia.org/wiki/Document_Type_Definition). If additional price element is added the code might still work, but the code doesn't know if it's using the right one anymore. 

There are cases when you might *not know* all possible data formats, like what I noticed recently when importing some data from Amazon reports. Everything seemed fine when we were testing, but once we launched some products were reporting with wrong quantities. The type field, which we stupidly ignored because it always showed *'Sellable'*, apparently can also be different and when it's different you should act differently. Obviously because we ignored it the data we imported didn't make sense - what we should have done is validate the data and have our assumption about type field in place, this could have notified us about that unseen format.

### Encoding

<div class="alignright" ><img src="/media/encoding.png" alt="Encoding" class="noborder"></div>

We had this issue when working with the [Edinburgh Festival API](http://blog.webspecies.co.uk/2011-07-04/building-the-edinburgh-festival-api.html) while migrating some import sources to a new location. Everything seemed fine and data was successfully imported, but after some time users pointed out that some of the characters we are returning are invalid Unicode sequences. After some investigation we found out that the conversion of ISO-8859-1 to UTF-8 was in fact incorrect and [Windows-1252](http://en.wikipedia.org/wiki/Windows-1252) was supposed to have been used.

Obviously it's very unlikely that encoding of the data might change, but, you know, sometimes things happen when you least expect them. Annoyingly encoding issues are easiest to spot by humans, because any single-byte encoding can be applied and it will work, kind of, but only an actual person would notice that the text it's showing doesn't make sense. Luckily computers now can guess too, by for example running this: 

{% highlight php %}
<?php
$str = 'áéóú'; // ISO-8859-1
mb_detect_encoding($str);
{% endhighlight %}

However results of this function are pretty unpredictable sometimes, although you can still use it to detect if data is a valid Unicode string, for example:

{% highlight php %}
<?php
$str = 'áéóú'; // ISO-8859-1
mb_detect_encoding($str, 'UTF-8'); // 'UTF-8'
mb_detect_encoding($str, 'UTF-8', true); // false
{% endhighlight %}

And if you are converting from a specific encoding to another one, say Unicode, test if result doesn't contain invisible characters or any other impossible sequences in human readable text.

### Conclusion

I can't stress enough how import data validation really is. There are so many attack vectors exploiting incomplete or faulty validation you can never be 100% sure all cases are covered. But rather than building a blacklist, go with whitelist approach, because most likely it's going to be better and if conditions change you can always fix it later.
