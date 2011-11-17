---
layout: post
title: One month later... Azure+ is dead
author: Juozas
email: juozas@juokaz.com
date: 2011-11-17 17:27:00
tags: [php, cloud, microsoft, windows azure, azure, azure plus, fail]
categories:
- PHP
- Announcements
- Cloud
---

<div class="alignright" ><img src="/media/fail.jpg" alt="Fail"></div>

What a ride this was... Just a bit more than a month ago I posted an [article](http://blog.webspecies.co.uk/2011-10-03/we-built-a-cloud-platform-for-php-wait-what.html) on the project we were secretly working on - [Azure+](http://cloud.webspecies.co.uk/), the PHP cloud platform built on top of Windows Azure infrastructure. From then functionality was improved, amazing additions were planned, I travelled tens of thousands of miles and showed it to hundreds of people. And now I can announce that it's dead. Here is what happened.

<!--more-->

If you want to know the "Why?" part you can skip the first few sections all together and just go straight to the sad part. However, this case is a bit complicated... Well ok, it's very complicated. And I can't talk about the main reason at all, so the only thing you will find is an "abstraction" of what happened. Something that I have no control of.

### The launch

<div class="alignleft" ><img src="/media/explode.gif" alt="Launch" class="noborder"></div>

The blog post about the project has to be the most popular post of this blog, it received well over 10'000 unique visitors in a day. I think this is a quite big number, which was mainly fueled by social networks as everyone wanted to see what can be done with Windows and PHP. That's why it had the "Wait... what?" at the end of the title - I assumed a lot of people would question the value of this kind of project.

And *oh my god* there was a lot of people who did. Microsoft guys were internet-high-five'ing us all the way, but the majority of everyone else was either still questioning the point of this or plainly calling it stupid. They had their reasons though - Windows and PHP are not really a welcomed topic, mainly because of the prejudice because it works just fine, even if [PaaS](http://en.wikipedia.org/wiki/Platform_as_a_service) shouldn't "expose" the OS it is running on (as much as that's possible). Also similar projects like [Orchestra.io](http://orchestra.io/) or [PhpFog](http://phpfog.com/) had taken off.

Ignoring the arguments online of whether it was a good project, the prototype that we launched worked flawlessly. One of the biggest demos of it was me doing a demo in my [PHP in the Cloud]( http://www.slideshare.net/juokaz/php-in-the-cloud-php-barcelona) keynote at the PHP Barcelona conference. Deploying an app on the stage with 500 people watching it... crazy, but it worked. Not once did it failed, even after showing it hundreds of times to all sort of different people I had a chance to show it to.

### What people are looking for?

You might not realize this, but PHP ecosystem is a bit different from any other language (as they are different from each other). PHP developers usually start their careers by just hacking on some code locally, because it only takes minutes to setup a PHP environment. And if something doesn't work - fix it and refresh. No need to recompile or deal with DLL hells. This obviously brings some disadvantages, but this post is not about how good or bad PHP is.

<div class="alignright" ><img src="/media/its-easy.jpg" alt="It's easy" class="noborder"></div>

Because of this upbringing, the tooling for PHP developers should follow this idea. And that's what we were trying to achieve and push the industry to do the same. One of the key elements of the platform was that you could always push code directly. As awesome as pulling from Git sounds, you can do way more than that by just executing one terminal command. And if it doesn't work - push again and refresh. 

A lot of Microsoft folks asked us about all sorts of different enterprise behaviours and how we are planning to support them. We are not, because PHP (and even non PHP) projects do not need them. Need a custom PHP setup - build your own servers, you are obviously qualified enough. Same applies to all sorts of custom or niche functionality and technologies. But most PHP projects do not need that. And that's why we didn't overcomplicated our solution, we solved the problem for majority of folks and for anyone else who needs some flexibility which we don't support - platform as a service is not right for you.

### Future architecture

Azure+ wasn't about being an abstraction on top of Windows Azure, even if initially it looked like one. The reason why apps would take 15 minutes to create was because we were spinning up new instances for every new app, this takes some time. Nonetheless the goal of Azure+ was to deploy apps to a "shared server" similarly to how [Heroku](http://www.heroku.com/how) does it (in quotes because it was not trying to be a shared hosting platform.)

<div class="alignleft" ><img src="/media/fast.jpg" alt="Fast!" class="noborder"></div>

Imagine that each server has N number of slots; each slot can host an app in a fully isolated and secured environment. If it happens that your app needs more resources than the slot can provide (thus not killing other apps), you get more slots - on the same server or other servers. Apps can scale beautifully, any extra modifications are not required and price of the service can match any other PaaS and beat it. If that's too crazy for you - you would still be able to choose dedicated boxes.

Once we would've had that and MySQL setup done, I'd say it would have been ready for the first public beta. We weren't that far actually - it would only have required some hardening of the web server and PHP, a bunch of reverse proxies and a DNS server. This setup works beautifully because applications can be scaled very dynamically by us and there is a cluster supporting the infrastructure so it's highly reliable. But then some things happened...

### Good bye

I was put in a position to kill it. Not forced, but continuing it anymore would make no sense. That's how much I'm going to say - I was advised to keep my mouth shut by some clever people in suits. Of course I'm sad to let it go after so much effort and time we have put into this, but sometimes ideas just don't work out.

P.S.  
Name *Azure+* was never an issue; it was chosen as a codename and would have been changed as the project progresses. 
