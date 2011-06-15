---
layout: post
title: RESTful web services with Python. The easy way
author: Juozas
email: juozas@juokaz.com
date: 2011-06-15 17:15:14
tags: [api, frapi, rest api, python, bottle, tornado]
categories:
- Python
- API
---

More and more projects are exposing their functionality via REST APIs. We think APIs are awesome and it's great what they've done for the web overall, but we also see a lot of bad APIs examples, like [Twitter API](http://dev.twitter.com/doc). It might be the case that if you don't have the right tools, it becomes hard to implement them correctly and quick. Lately we have been working on a couple APIs and I decided to share our experiences and why we went with Python in the end. 

<!--more-->

### What APIs should do?

<div class="alignleft" ><img src="/media/rest.gif" alt="Rest" class="noborder"></div>

As little as possible ideally. In most cases it's just a layer on top of a database or search server, providing a RESTFful way to access data and get it back in some fashion understandable by a client. The less code there is, the lighter it's and the easier it's to make changes the better. And with a rise of popularity to expose data and functionality using APIs it should behave following REST and HTTP standards, so it can be adopted in no time. 

Depending on how you want to do it, you can also go full RESTful or just pretend that what you are doing is a REST API. Supporting [Hypermedia](http://en.wikipedia.org/wiki/Hypermedia) for example is something you are supposed to do, in theory. But at least the API should handle HTTP Accept headers correctly, use native HTTP authentication like Basic Auth and have meaningful resources' URLs. Just that will make it somewhat much better than most APIs out there. 

Importantly, web services should be as fast as possible and support huge amounts of requests per second. In most cases APIs are called from other applications and the more time it takes for your API to respond the slower that application belongs. You should aim at no more than 10ms to fulfill the request. And if application developer decides to retrieve some resources in a loop, your API server shouldn't crash either. 

### Python or not

<div class="alignright" ><img src="/media/snake.gif" alt="Snake" class="noborder"></div>

Although we might seem as a PHP company, we are not really - we use PHP for websites, where it works best and nothing else. The reason why we tend to go with Python is simply because it's just perfect for what I described above. There are libraries for pretty much anything when it comes to reading and writing data from any storage and it's super lightweight compared to a lot of other languages. 

Don't get me wrong - there is nothing wrong with any other languages; it's just that Python worked really great for us. However if you for example want to stay with PHP, [Frapi](http://getfrapi.com/) might be a good option. Although you can't really achieve a lot of things as easily as with Python and the language is just much more concise. Performance is a questionable topic, but from our experience Python wins any day. 

From functionality perspective [decorators](http://www.python.org/dev/peps/pep-0318/) allow achieving a lot of things without destroying application flow with endless listeners and callbacks. When I need to provide authentication for the API, I just wrap the application with `@auth` or when data from some API call needs to be cached it just gets wrapped with `@cache`. Makes workflow really clear and doesn't require nested if structures and duplicated logic. 

### API in a Bottle

<div class="alignleft" ><img src="/media/bottle.gif" alt="Bottle" class="noborder"></div>

[Bottle](http://bottlepy.org/) is one-file web framework based on [WSGI](http://www.wsgi.org/wsgi/), thus it works just as any other Python framework. It's not really made for APIs exactly, but it works great for them. API looks a lot like [Sinatra](http://www.sinatrarb.com/) - it just maps routes to actions (functions). What is more, I find it to be allowing very rapid developing. In most cases I can write whole API in less than a day.

Compared to other Python frameworks it doesn't do anything that special, but where it shines is that a lot of the things can be either configured or swapped for different ones. It's just a box of building blocks with some default behavior, but from there you can really make it work in any way you want. If you need real-time web services allowing you to push data to clients, [Tornado](http://www.tornadoweb.org/) might be a better choice.

Here is an example of the simple API, with first method returning plain string and second being automatically converted to JSON string:

{% highlight python %}
import bottle
from bottle import route, run

@route('/', method='GET')
def homepage():
    return 'Hello world!'
    
@route('/events/:id', method='GET')
def get_event(id):
    return dict(name = 'Event ' + str(id))
   
bottle.debug(True) 
run()
{% endhighlight %}

<div class="alignright" ><img src="/media/xmlvsjson.png" alt="XML vs JSON" class="noborder"></div>

A lot of functionality can be tweaked using plugins, so rather than allowing Bottle to automatically convert data structures to JSON, you might want to use plugin like this to return data strictly by the type client accepts: 

{% highlight python %}
class FormatPlugin(object):
    name = 'format'

    def apply(self, callback, context):
        def wrapper(*a, **ka):
            # Check if return data format is supported
            accept = request.environ.get('HTTP_ACCEPT')
            if not accept in ['application/json', 'application/atom+xml']:
                return HTTPError(500, "Unsupported data format")
            
            # Execute the action    
            rv = callback(*a, **ka)
            
            # Write out results
            response.content_type = accept
            if accept == 'application/json':
                return json.dumps(rv)
            elif accept == 'application/atom+xml':
                return render_xml(rv)
            return rv
        return wrapper
{% endhighlight %}

When it comes to performance we haven't maxed it out yet. Usually we tunnel multiple Bottle applications through Nginx pool using uWSGI as a web server, which we chose because of the [benchmarks](http://nichol.as/benchmark-of-python-web-servers) done by Nicholas Piël where you'll see that uWSGI demonstrates amazing performance. For this article I did some benchmarks on a VirtualBox VM with one core and I was getting at least 2000 req/s from an API talking to Mysql and MongoDB servers to fetch different data.

### Conclusion 
