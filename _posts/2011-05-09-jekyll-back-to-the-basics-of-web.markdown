---
layout: post
title: Jekyll - back to the basics of Web
author: Juozas
email: juozas@juokaz.com
date: 2011-05-09 16:35:13
tags: [jekyll, html, ruby]
categories:
- HTML
---

When considering which platform to use for our website and for this blog I had a couple choices\: use Wordpress or any other CMS, build our own custom solution or have a completely static website. I went with none of those and chose a small tool with great powers - *Jekyll*. This post is a walkthrough and an introduction to it and when it makes sense to use it.

<!--more-->

Jekyll is a static site generator and that’s exactly what it does - turning a collection of templates into HTML files. You can then deploy them to any web server and all of a sudden website is live. Content can be written using your usual editor, so you can write your blog with VIM if you feel like it. Absolutely no need for a database, PHP or any other external dependency, which brings us to Jekyll advantages.

### Advantages

Well, it generates HTML pages, so it makes a secure website (you can’t really hack a HTML page, now can you?). In comparison, Wordpress is known to have security holes, as any software you say, but blogs are often under heavy attacks by spam bots, so the more secure the better. Unless you have misconfigured your server, I doubt it’s even theoretically possible to get hacked.

HTML pages bring another advantage of being crazy fast. PHP for example is fast enough for most of the stuff, but still falls behind static pages, for obvious reasons. I like fast responding websites and the only limit I want to have is how fast my internet connection is. This blog is being served by Nginx, an awesome tool by itself, and load times are pretty much instant.

I have started my carrier by creating HTML websites years ago and still can do it very quickly. Once I have received a HTML code from my designer I don’t need to wrap it around Joomla or Wordpress specific template structure - with Jekyll it can be used as it is. Makes it ideal for creating websites fast and because there aren’t billion templates, views and partials to juggle with, fixing bugs in markup is child’s play.

### Disadvantages

<div class="alignright" ><img src="/media/backtobasics.jpg" alt="Back to basics" class="noborder"></div>

Static pages are static, thus requiring some workarounds for your usual dynamic parts. Contact forms cannot be implemented as there is no handler for handling the POST data. Luckily there are services like [Wufoo](http://wufoo.com/) which work for most of the tasks, but require more fiddling that just creating a PHP handler. Same is for comments, ratings etc. anything requiring to store data.

There is no online interface for editing so it won’t work well for clients' websites. I can image hacks which would make it somewhat possible, but let’s leave them out. This is not an issue for me as there is no need to edit anything on this blog once it’s deployed (I can redeploy in a matter of seconds anyway), however clients will need this feature. Thus rendering Jekyll usable only for your own projects or limited-editing websites.

That’s pretty much it. Well, at least for me. If none of that sound like a big show stopper, I suggest you try it out.

### How do I start?

Project is [hosted](http://github.com/mojombo/jekyll/) on Github with full installation instructions, but in most systems it can be installed as easy as using:

{% highlight bash %}
gem install jekyll
{% endhighlight %}

Then you obviously need a sample project. Create `index.html` and `_config.yml` in some folder and run this command from it:

{% highlight bash %}
jekyll --server --auto
{% endhighlight %}

This will launch a web server and `--auto` command makes it monitor directory for changes, so as soon as you change some files it will regenerate the site. Guide your browser to `http://localhost:4000/` and you should see your website. You can go from there and start adding more pages, using layouts etc., all this information is in the manual. One last thing - generated website is stored `_site` folder and this is the folder you can deploy to anywhere.

I use Markdown for most of the content, but it supports a bunch more and obviously regular HTML files. Templates can be written using [Liquid](http://www.liquidmarkup.org/) language which is quite nice and more complicated tasks can be written as plugins (categories and tags pages on this blog are generated with them). There is a gallery of websites based on Jekyll [here](http://github.com/mojombo/jekyll/wiki/sites).

### Conclusion

Next time you are considering building a not complicated website or a blog give a look at Jekyll. It worked great for us and I’m very happy with flexibility and lightness of it. It’s also very easy to start with and potentially Liquid templates can be later migrated to other frameworks (Liquid is for example very close to [Twig](http://www.twig-project.org/)).

P.S.  
**Source code of this blog is actually opensourced** too and available [here](http://github.com/webspecies/blog.webspecies.co.uk/), so feel free to hack with it. You can do this:

{% highlight bash %}
git clone git@github.com:webspecies/blog.webspecies.co.uk.git
cd blog.webspecies.co.uk/
jekyll --server
{% endhighlight %}
