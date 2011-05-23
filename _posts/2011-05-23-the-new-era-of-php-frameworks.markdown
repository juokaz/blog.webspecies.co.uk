---
layout: post
title: The new era of PHP frameworks
author: Juozas
email: juozas@juokaz.com
date: 2011-05-23 17:51:13
tags: [php, symfony, zend framework, lithium, cakephp, ruby on rails]
categories:
- Frameworks
- PHP
---

I have worked on a lot of different systems and projects in my years and most of that was spent doing PHP. However just recently I have noticed a new major point in time - a new era of PHP frameworks. Seems like everything is changing these days. I want to discuss what I think the current state is, what’s wrong with it and how the new *gang* of frameworks is going to change it.

<!--more-->

On May 21st I have delivered a talk at Dutch PHP conference (DPC in short) about this topic and I had very interesting discussions to follow it. To start with [here](http://www.slideshare.net/juokaz/the-new-era-of-php-frameworks-dpc) are the slides of the talk, of course keep in mind that they do not work that well without me talking. This article is a brief version of what I talked about.

### Frameworks are born

<div class="alignright" ><img src="/media/useframeworks.png" alt="I use PHP frameworks"><p class="wp-caption-text">I use PHP frameworks</p></div>

6 years ago CakePHP, one of the first PHP frameworks, was released and from then we’ve seen a plethora of PHP frameworks. Currently there is about… a million of them, all with their different MVC, DBAL and templating implementations.  I like them, even if they have their weirdness’s, but still their adoption is not massive.

If you’d look at numbers of PHP open-source projects **based** on frameworks, you’d see that there is only a few. Which is sad. Partly the reason is that a lot of those projects were released before any PHP frameworks even existed, but also because doing some work with a PHP framework required quite some learning. Thus if a project is to be based on a framework it would increase the learning-curve, at least in most cases.

Nonetheless they have changed how we do PHP. A lot of developers claim they know OOP, but when frameworks came they were forced to actually prove it (before that you can hack in any way you want). And frameworks have thought millions of PHP developers what is real OOP and how it works. Ask someone to use `mysql_query` nowadays and you might get punched in a face. Twice. Because they would also need to use `mysql_real_escape_string`.

### How it was done?

No one really knew what PHP frameworks should be. Nor what features they might have. So how did people managed to make them happen? Well, they either followed existing frameworks in other languages (like RoR) or came up with their own ideas. Because experience was not there, most of the frameworks up to today have legacy designs which everyone knows are bad, but are impossible to fix.

Pragmatic approach of PHP developers here helped a lot - similarly as how PHP as a language evolved, PHP frameworks also changed and grew driven by feedback and requests. In a couple years most people were happy with what we had. But if you’d look closely in 2007 we had Zend Framework 1.0, which had, compared to 1.11, a very limited feature set. So even today frameworks are evolving rapidly to meet features’ needs.

PHP 4 was (and surprisingly still is by some of them) supported by all the frameworks. This led to a lot of code which is now very out-dated, especially the OOP paradigms. Trying to support this has led to complicated process of implementing new features and fixing bugs. Furthermore, less and less developers want to work on such old code anymore.

### What’s broken?

<div class="alignleft" ><img src="/media/phpmagickkills.png" alt="Magic kills"><p class="wp-caption-text">Magic kills</p></div>

First of all, back then it was very popular to use PHP’s magic functions (`__get`, `__call` etc.). There is nothing wrong with them from a first look, but they are actually really dangerous. They make APIs unclear, auto-completion impossible and most importantly they are slow. The use case for them was to hack PHP to do things which it didn’t want to. And it worked. But made bad things happen.

*SCOP* - Static class oriented programming, is a term I invented to describe most of the PHP code. Static methods are bad for a lot of reasons I’m not going to dive into today, but most importantly if a class is a collection of static methods, it’s nowhere near OOP. It’s just using a class as a container for functions. There are even full frameworks just doing this.

Zend Framework for a long time was my favourite PHP framework (and still is for PHP 5.2), but my main issue with it is that it’s trying too hard to be a component library. Other frameworks followed the same path - rather than using existing libraries, they wrote their own. This has created so many libraries inside PHP which are kind-of standalone, but still require downloading whole framework. Fat frameworks are really annoying.

### The new era in 2011

To improve this situation people have chosen to do a couple of things. But mainly is to rewrite frameworks from scratch on top of PHP 5.3. This allows to establish new standards, agree on interfaces between all frameworks and throw away all (most) legacy problems. Sounds easy, but only by doing these things we can enter the new era of frameworks.

I haven’t used any frameworks before CakePHP was born, so I’m going to use it as a landmark. Actually I even doubt there existed anything before CakePHP, of course if you don’t call Drupal a framework. From CakePHP years till today 6 years have passed which I mark as first era. 2011 marks second and completely new things will finally happen, mainly in a form of releases and announcements.

Interestingly, in 2011 PHP is no longer PHP. Or no longer just PHP. LAMP stack is boring and less and less used with new tools like Nginx and CouchDB available. Today integration and interoperability are crucial elements. Same is for language - PHP 5.3 is a completely new beast which makes possible for amazing functionality, and if you do PHP 5.3 there is no real backwards compatibility support to do.

### Let’s fix it then, shall we?

<div class="alignright" ><img src="/media/usegit.png" alt="Use git"><p class="wp-caption-text">Use git</p></div>

Moving to GIT allowed a lot of frameworks to make it easier to contribute. I’m mostly impressed with Symfony results, because they have managed to attract huge number of contributors (see the graph [here](http://github.com/symfony/symfony/graphs/impact)). Current pace is much faster and compared to few years ago frameworks are improving at much higher rates.

A lot of trimming has been done. First of all, all that magic I was mentioning earlier is now gone and explicit definitions are used all over. Furthermore, there is more thinking towards having a small core and additional features coming through extensions and libraries. This is a great way to make it easier to work with frameworks and reduce memory footprint.

Performance was a major issue for PHP frameworks and most of them had it in their plans for new releases. Front-end received a lot of attention too with frameworks like Symfony helping with assets (JavaScript and CSS) management and proper headers for static content. PHP side profited from removed magic and code clean-up, and PHP 5.3 added a huge performance boost.

### New features

Obviously all the new language features are incorporated. Like namespaces for example. Namespaces support lead to needing to research and agree on autoloading approach which would work for most of the frameworks. [PSR-0]( http://groups.google.com/group/php-standards/web/psr-0-final-proposal) was born earlier, but is now well integrated into frameworks. And then anonymous functions are finding their way in.

[Dependency injection containers](http://pimple-project.org/) and [Annotations](http://www.doctrine-project.org/projects/common/2.0/docs/reference/annotations/en) are two I’d like to mention here; both change how you code. I like using them and Symfony makes great use of them, but other frameworks are catching up and should start to incorporate them soon. Combination of those and new PHP features allows to create very clean micro-frameworks, look at [Silex](http://silex-project.org/).

I’m not entirely sure that I like growing list of features directly ported from Java environment. Java works differently (and requires 1GB of RAM) so even DiC is tricky in PHP. We’ll see where it gets us, but so far I’m a bit worried because I know that PHP likes light systems rather than complicate objects’ graphs. As much as cool those patterns sound, they can create more problems then solve.

### So when?

<div class="alignleft" ><img src="/media/symfony2release.png" alt="Symfony2 release"><p class="wp-caption-text">Symfony2 release</p></div>

[Zend Framework 2.0](http://framework.zend.com/) is on its way, but will take some time. Because ZF has a massive code base first thing they did was to convert it all to namespaced code. Once it was, it was time to start refactoring functionality and implement new one. Currently the work is being done on MVC part, but I’d hope late this year a final release might happen.

[Lithium](http://rad-dev.org/lithium) is about to be there, it’s in dev mode, but seems pretty close to finished. It’s a completely different framework from those regular ones, so it would be worth to check it out. I’m mostly impressed with their [AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming) implementation and would like to see adopted in more frameworks. Obviously they are PHP 5.3 only, but they do support CouchDB and MongoDB quite nicely.

[Symfony2](http://symfony.com/), in my opinion, is leading the pack. They are currently in beta2 and final release is a matter of months it seems. List of features is hard to grasp, so it’s worthwhile checking them out in their website, but to name one - Bundles. Bundles are a way to have extensible application structure with a collection of components from outside. Think plugins.

### Conclusion

I’m super excited about the things currently happening in PHP industry and I believe they will lead to great achievements.  Finally we have a time when we can throw away all (most) our legacy and implement fresh ideas. Fast forward 5 years from now we should be as excited as we are today.  
