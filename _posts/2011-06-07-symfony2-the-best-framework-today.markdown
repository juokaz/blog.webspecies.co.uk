---
layout: post
title: Symfony2 - the best framework today?
author: Juozas
email: juozas@juokaz.com
date: 2011-06-07 15:55:14
tags: [php, symfony, symfony2, zend framework]
categories:
- PHP
- Frameworks
- Symfony
---

<div class="alignright" ><img src="/media/symfony2.png" alt="Symfony2" class="noborder"></div>

I used to use Zend Framework extensively and still believe it's the best framework for anything what doesn't support PHP 5.3. However a couple months ago I started using [Symfony2](http://symfony.com) for internal tools at Web Species and have stayed there since. It has its problems and flaws, but let me give you some thoughts why I think it's the framework which is going to go big. Very big.

<!--more-->

Frameworks are big creatures and naming interesting features can take thousands of words, so this is just a short glimpse of the few things I find interesting, to me. Obviously there is much more to it. Hopefully you won't find yourself feeling like this guy:

> I have nothing against Symfony2, I've been using it and it's great. But this blog post is nothing but a gushing verbal sex exposition with Symfony as the subject.

### What I like about it

First of all, once you grasp how it works, it starts to produce great results. I was really sceptical at first, because it seemed very complicated and over-engineered, however after few days of work I started liking how it works. And that's the thing about Symfony2 - after some time it starts to feel great to work with it, it even makes working with PHP interesting again. Once you know how to configure it properly it starts to play along. 

Not a big secret, but I'm quite a Doctrine user and the fact that Symfony2 integrates with Doctrine2 out-of-the-box just makes things easier. For example working with forms is way simpler now because it can create forms out of entities' definitions and also [populate](http://symfony.com/doc/current/book/forms.html#forms-and-doctrine) data to entities. And integration for Doctrine CLI is obviously there, so the only thing you need to do is to specify connection properties and everything just works, in theory.

But that's all code which is replicable to other frameworks; the most impressive bit is bundles. Bundles are small self-contained plugins allowing sharing some functionality between different projects. And GitHub is just [flourishing](http://symfony2bundles.org/) with all sorts of different ones, showing how much people are interested in this framework and are actively using it. Using bundles makes Symfony2 core smaller, but also gives more flexibility with how you bootstrap a new project.

### Business reasons

As much as I'm still involved in writing code, I need to make business decisions at the end about tools, frameworks and languages we use. And the tools I tend to go with are the tools I believe in can stay around for years to come and are, obviously, high quality and *popular*. Without any doubt Symfony2 is the fastest growing framework and quite quickly should become the most popular out of all. 

There are a lot of not as well-known frameworks out there which are quite good and work somewhat well, but the reason I'm not using them is because they are not popular enough, which makes me question if they are actually that good. It's hard to find developers with experience, it's hard to find blog posts and discussions online and I'm unsure how long they are going to stay with their limited contributors list. Symfony2 makes me feel [safe](http://symfony.com/contributors) so far.

It's hard to answer why, but for me Symfony2 looks the most professional and/or professionally-developed framework. Party because I know a lot of companies and people working on it personally and I know they can deliver, but also because code quality they produce is amazing. And with the amount of developers constantly contributing I can see it being actively developed and becoming even more solid.

### The bad parts

A lot of the things in this framework still have to be proven to be the right decisions. I know a lot of people, who love Symfony2, but at the same time there is a big group who just hate it, and they have different reasons. Maybe because it has a very steep learning curve, at least now, but also because of some of the design ideas. 

I've mentioned this briefly in my blog post about [frameworks](http://blog.webspecies.co.uk/2011-05-23/the-new-era-of-php-frameworks.html), which is the fact that I see a lot of Java patterns and ideas being used in PHP. This is a big topic and I might blog about it sometime, although I have nothing against Java *(he he)*, but even things like Dependency injection containers just don't feel *right* (when used in PHP).

DiC does work fine when you can load objects' graph into memory and provide dependencies when needed, but nature of PHP is very different from Java and that graph needs to be built on each and every request. Of course the performance problem or impact, to be exact, can be solved in some ways, but the difference is still there. So as much as I like this idea, I'm not yet fully confident that it will work well.

This brings us to another problem with Symfony2 - the amount of configuration involved. When I was starting with Symfony2 it took me quite some time to figure out how to achieve even simple things. Maybe the framework went too far with removal of magic, right now it feels quite demanding and asking for everything to be configured explicitly. And once an exception is thrown somewhere deep in core, good luck figuring out why is it happening.

### Conclusion

I think we made a right decision choosing this as a base for our web apps and are starting to receive more and more inquires about [Symfony training](http://webspecies.co.uk/training/symfony) courses and consulting we do, which just shows that popularity is growing and growing. It does have some issues and sometimes just feels clunky, but overall allows producing high quality projects and being sure about the results. I feel confident investing in Symfony2.
