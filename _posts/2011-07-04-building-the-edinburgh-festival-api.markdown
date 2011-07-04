---
layout: post
title: Building the Edinburgh Festival API
author: Juozas
email: juozas@juokaz.com
date: 2011-07-04 17:10:00
tags: [api, rest api, webspecies, edinburgh festival]
categories:
- API
- Announcements
---

Couple months ago we started working on a very exciting project - building data access API for world’s largest cultural event, the Edinburgh Festival. It was a very exciting journey and here I’m sharing how we built it and what’s the stack used. The goal of this is to show how we solved specific problems and how you might apply it for your applications.

<!--more-->

### The problem

We started from having a specification from [Festivals Lab](http://festivalslab.com/) of what this API is supposed to be doing and that was a really trivial task - outputting data of 7 different sub-festivals in one format. And this is just about right what this project was about. We took the data from various sources, processed into formats we could understand, did some filtering, cleaning up and validation, and pushed that data through the API.

Of course this is just a read-only API, so that changed the design a lot. There was no need to connect to an actual database from the API server, but rather to a search server, which would be faster and more reliable for data lookups. And reliability was one of the requirements, because as with all APIs they should always work, *in theory*. Having a database and search server decoupled allowed increasing fault-tolerance and scalability.

What we tried to achieve is that even if all the servers would die, we can spin up a new one, run some scripts and API is back live. Thus data imports were supposed to be deterministic and fast. Once we got that, we were certain that even if things go horribly wrong we can recover very quickly and for smaller cases database’s and search server’s redundancy is protecting us.

### The stack

<div class="alignright" ><img src="/media/festivalapi.png" alt="Festival API" class="noborder"></div>

#### Processing

Interestingly this is the part where we spent most of the time, because chasing for data has proven to be very challenging. However once we got all data in sensible formats, we wrote a collection of self-contained scripts processing the data into various our formats. 

Key lesson here was that Excel is used very commonly and there are problems with most of the Excel file parsers out there. Especially with Unicode characters, which worked fine in most cases, but sometimes would just fail to unrecognizable chars. Exporting to CSV first and then reading that from the scripts was how we solved this.

#### Database server

Obviously data coming from data sources needs to be stored somewhere. Overall the structure was very trivial, only consisting of events containing a list of performances. So MySQL could have worked here easily, however the problem was that data structure was different between different festivals and also it was constantly evolving during development process. 

Hence we went with CouchDB because of its reliability and the fact that we can just store events as nested objects.

#### Search server

One of the key elements of this API is to be able to filter data efficiently. [ElasticSearch](http://www.elasticsearch.org/) was chosen because it integrates with CouchDB almost out of the box, so it was as hard as executing [one query](http://www.elasticsearch.org/blog/2010/09/28/the_river_searchable_couchdb.html) and we had a (almost) real-time representation of data stored in a database, searchable through the API. 

ElasticSearch also allows to kick-start in 5 minutes, without a need to define document’s structure allowing to add those later to optimize the performance. It supports anything Lucene supports too, so it wasn’t like we were throwing out possible features.

#### API

As I explained in the previous [post](http://blog.webspecies.co.uk/2011-06-15/restful-web-services-with-python-the-easy-way.html), we use Python for all APIs. This wasn’t an exception. However, the actual API is just couple hundred lines of code - very thin layer on top of the search server, which is using HTTP interface anyway so there was no need to use any libraries too. 

[Nginx](http://nginx.org/) was used as a proxy for API servers, each monitored by [supervisor](http://supervisord.org/). Deployments are obviously made using Ant and any task is one-click operation here, so any updates can be rolled out in a matter of minutes. 

### The outcome

Well, it works. In our internal tests we tried to make it go down, but it sustained them all quite well. We can't share performance characteristics of the application, but it's pretty damn fast and the servers have no problems with the load.

There is logging for all requests coming in, storing information about which API user accessed what sort of information. This should be producing some interesting results we might be able to share later. The API is going to be used in some mobile apps too and we haven't worked with those before, so we will learn how use cases are different from mobile applications compared to websites or desktop applications.

Festival only runs for less than two months, so this project is quite short-lived, but there are big plans for next year to open the data even more. If it was us to decide, we would make it fully public and do not require any license agreements, but this is not the case, so we are going to push hard for this for next year.

### Conclusion

Clients seem to be very happy about the outcome and we are happy because we had a chance to work on a very challenging and important impact-wise project. I made all those decisions, of course after discussions with the clients, and they seem to work so far. Any tips for future projects?
