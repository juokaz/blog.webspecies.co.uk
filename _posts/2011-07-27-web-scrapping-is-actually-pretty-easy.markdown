---
layout: post
title: Web Scrapping is actually pretty easy
author: Juozas
email: juozas@juokaz.com
date: 2011-07-27 14:10:00
tags: [webspecies, sellerscout, web scrapping, python, php]
categories:
- Python
- PHP
- Web scrapping
---

For some of our clients we worked on extracting or submitting data automatically from websites which didn't have an API we could use. This and more is called web scrapping. Since our announcement of [SellerScout](http://sellerscout.co.uk/), which relies heavily on this, I received a list of questions how we actually do this. So here is some thoughts on how to start in the interesting web scrapping world.

<!--more-->

This article talks about some basics, which will work fine for most cases. This is probably not even remotely close to how Google does this or how we do it at SellerScout. The reason being both of those systems work in much larger scale and use cases are different. For example relying on machine learning, text analysis and semantic search algorithms etc. are all the things you might be doing if you want to build something big.

### Downloading the web

Spiders are the small applications you are going to be writing. Usually they are self-contained and CLI-friendly scripts, which have some internal logic how to extract information from a specific website or websites. As an example, the script might go to website homepage, download all the category pages, download products list for each of them and extract a list of products in the store.

If you are a Python guy, you might want to look at [Twisted](http://twistedmatrix.com/trac/) or [Scrapy](http://scrapy.org/), later being very easy to use. If it's PHP you are using, combination of Curl and libxml will allow doing the same; I'm not aware of any PHP frameworks for this. For any other language, you should give a look at Google. 

Is it legal? Depends. There is no strict answer and it varies on what data you are trying to extract. Some data can be copyrighted, for example original texts, so if you are scraping them and showing in your website - you are being a bad person. Stop! Ideally you should discuss this with your lawyer, which we did, and get some thoughts on how to proceed. 

### Getting blocked?

One of the decisions you need to make is how you are going to identify the spider - you can either replicate normal browser's headers or introduce the spider by its name (eg. ‘googlebot'). First one will allow you to stay undetected, probably, while later one is considered to be the correct way. From my experience, for anything small Firefox headers will work just fine. 

Websites might still decide to block you though, and it's something you might want to be prepared for. If you are identifying the spider by a name, you should respect [robots.txt](http://www.robotstxt.org/) and stop crawling if you are being denied by that file. However the most likely blocking mechanism is to block your IP address, which is going to happen if you are being stupid. Really stupid.

You see, when people are browsing the web they request 1 page each 3 or 4 seconds, hence if you have a list of 1000 urls to download and you just start iterating over them and issuing requests… Well, you are easy to catch by just looking and access logs. Don't do this. Rather have a queue of urls to download and issue with a random delay from a range of 1 to 5 seconds.  It's going to take longer, but it will help to avoid problems.

This doesn't scale though, you might say. And in fact you are right, because 5 seconds delay between each request limits the amount of content you can download per day. Luckily for you, I have a tip here too - use proxy servers. It's going to require writing a requests scheduler, but if you need to download the same 1000 urls you might as well distribute them over a list of proxies each with their own delay times. The more proxies you have the amount of content you can download increases linearly. 

### Extracting the data

Once you have the HTML you want to process (to extract links to follow or to extract actual data), you might wonder how to actually do it. There couple of ways and libraries for this, however if you want to keep it simle using XPath or CSS-like queries is going work just fine. If you feel like, and believe me sometimes there is no other way, you might go with using [regular expressions](http://en.wikipedia.org/wiki/Regular_expression) for this, but that's got problems I'm going to talk just in a second.

I tend to go with [XPath](http://www.w3.org/TR/xpath/) because it's very easy to write and to debug. Furthermore there are various extensions you get for your browser which will allow creating those queries and test them on the actual website. I have worked on spiders for over a 100 different websites and XPath worked fine all the time, as long as…

The problem you will need to solve is how to process invalid HTML or XHTML markup. And from my experience, I'm yet to see a website with all pages being 100% valid. The more invalid it is, the harder it's to fix those problems. There are libraries though, most famously [BeautifulSoap](http://www.crummy.com/software/BeautifulSoup/), which will try to process invalid markup. They do have performance implications, but keep it in mind because you won't be able to issue XPath queries on invalid syntax.

Now let's get back to regular expressions. Theoretically they might look awesome, because they can extract data even if the HTML markup is invalid, however the problem is that soon they get complicated and very easy to break. XPath allows you to work on a DOM tree, hence if the website structure change they just stop working completely. Regexps on the other hand might still work, but produce very unpredictable results.

### Conclusion

We, as a company, a lot of experience web scrapping the data and it's actually very very easy. As long as you follow the logical rules and don't try to over-complicate the data extraction, you could easily extract all news items, products or blog posts in 30 or so code lines of spider. I can talk on this for hours or days, so I might write more on this soon, because this is just a top of an iceberg. 
