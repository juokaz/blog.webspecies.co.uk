---
layout: post
title: JavaScript is not your boss
author: Juozas
email: juozas@juokaz.com
date: 2011-05-05 17:45:13
tags: [javascript, html]
categories:
- JavaScript
---

If you’d have met me personally you would probably know that I don’t like JavaScript. But in a different way. I don’t like JavaScript because most of the time, I believe, it’s implemented in a way which just doesn’t make sense. It still makes sense for the end-user, which is awesome, but from *what-web-was-supposed-to-be* balcony it’s far far away.

From my perspective, JavaScript is a layer of logic (or code) sitting **on top** of HTML. So you have a HTML page with links, images and text, and some JavaScript which makes nice animations, adds Google ads and maybe something else. Is it always like this? Well, you guessed it – no. Let’s dive in to see how we can make things better, without using Flash of course.

<!--more-->

### Content

<div class="alignleft" ><img src="/media/javascript.jpg" alt="JavaScript language"><p class="wp-caption-text">JavaScript!</p></div>

Let’s go back a bit and see what JavaScript offers and how it changed websites. First thing which comes to my mind is Ajax – a way to asynchronously retrieve some data after the page has finished loading. This post is going to be mainly about it. 

You might have a product page with a few tabs like “Description", “Specifications", “Reviews" etc. and each of those is loaded dynamically when that tab is clicked on. Makes it possible to fit more data in one page and have use chose which one to show. I love it when websites do that.

But this functionality should not break the website structure from JavaScript-disabled browser’s point of view. Nowadays one might ignore the users who have chosen to disable JavaScript, but what you can’t ignore is Google. And the reason why you can’t ignore Google is because it makes you money; at least it does for most of the websites I had a chance to work on.

### Missing content

Now if you look at the product page example I have mentioned above, if it is implemented like I have described, with all tabs being loaded once requested, search engines’ spiders cannot see their content. And this is **bad**. All of the sudden you have valuable, relevant and semantically related information not being in that page, which makes that page rank low for a lot of valuable keywords. I’ve seen this happen a lot.

There are cases when it is *allowed* to ignore all of this, for example if you are [Grooveshark](http://www.grooveshark.com/). But this is more like an exception from a rule, in most cases it’s recommended to have HTML fall-back version of the website.  Of course this is going to require more work than just creating a JavaScript-only version; however benefits of doing so are going to be larger.

### Browser side

Ajax also allows to POST data back to the server without reloading the page. So contact form can show a nice thank you message without redirect user to any other page. Again, pretty cool feature. But when you start doing big forms (think order page) like that… You should be smart. Even if you do validation with JavaScript to make it faster for user to order something, you still need to do it server side also. Maintaining two sets of rules is tricky and you might get hacked. I was, once.

If you are a frontend developer you know that some things just can’t be achieved without some JavaScript sauce. Of course it’s quite crazy to expect a website to look/behave exactly the same when JavaScript is not available, but it should work.

### “The right way"

> Don’t code for JavaScript, code for content. Content is the boss, not JavaScript.

When I can I start by defining website structure, implementing all the underlying logic and pretty much finishing the whole website, before I start working on JavaScript. Obviously this is a generalization, but you get the idea. Yet again we can look at the product page example – once ready, add JavaScript to hide some parts of the HTML, thus only showing the current Tab. From user perspective UX is exactly the same.

If client/designer/kitten asks for some fancy navigation, have it mind, but don’t create a website based on that idea. Not because the requirements might (will) change, but because you are coupling presentation to data. If with disabled JavaScript a website doesn’t work at all or it’s impossible to navigate, you have coupling. And coupling is bad. And will make things bad, sooner or later.

Even simple things like lightbox effect (a popup-like window with enlarged image) should, ideally, work just fine without JavaScript. When it’s done like this:

{% highlight html %}
<a href="big_image.jpg" class="lightbox"><img src="small_image.jpg" alt="Image" /></a>
{% endhighlight %}

It’s clean and clear. When like this:

{% highlight html %}
<a href="javascript:onclick(openImage(‘big_image.jpg’))"><img src="small_image.jpg" alt="Image" /></a>
{% endhighlight %}

You are asking for problems.

### Conclusion

This is not in any sense an argument against using JavaScript. It can help achieve amazing things, especially together with HTML5 (allowing to make RIA apps). But make sure website makes sense from JavaScript-disabled access points’ point of view, for example Google should be able to index all the data without any tricks.

P.S. 
*Hashbang* is omitted from this post to make it less rantty. This doesn’t mean hashbangs are good. They are not. 
