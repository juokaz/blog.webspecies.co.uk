---
layout: post
title: We built a cloud platform for PHP. Wait… what? 
author: Juozas
email: juozas@juokaz.com
date: 2011-10-03 15:27:00
tags: [php, cloud, microsoft, windows azure, azure, azure plus]
categories:
- PHP
- Announcements
- Cloud
---

We built a cloud platform for PHP. Yep, you heard it correctly. We see a huge opportunity in the market and are willing to work hard to make deploying PHP projects very easy. However this is a different one and here is the story behind it and what it can do for you.

<!--more-->

We call it [Azure+](http://cloud.webspecies.co.uk/). Similarly to C++ relation to C, Azure+ is Azure done right and useable. This is a code name though, which might change once this goes to production. As will design, which currently works as a good basis and is based on the great [Twitter's Bootstrap](http://twitter.github.com/bootstrap/) framework. 

### Why Azure?

<div class="alignright" ><img src="/media/azure.png" alt="Azure"><p class="wp-caption-text">Current workflow with Azure</p></div>

There is nothing specific about [Azure](http://en.wikipedia.org/wiki/Azure_Services_Platform) that we wanted to leverage, but because so many existing PaaS providers are built on Amazon cloud it just made sense to try something else. Furthermore, I have a lot of experience with Windows and PHP so it all felt like a good plan. I think we are awesome enough to make Azure rock for PHP, because...

Azure is just impossible to use for PHP today. This is **a** fact. Doesn't matter which way you look at it, it just su.. isn't particularly good. The amount of steps you need to make, the knowledge you need to have and the fact that you can only deploy from Windows host are some of the things which make it a very painful experience. I had enough of this pain.

What is most important, I find Microsoft's approach and tooling lacking in so many areas, that the only way I knew how to fix this was to build a service on top, rather than release Azure+ as a product or open source project. There was and still is no way I can change the 15-20 min. deploy time (try debugging a non-working app having to wait half hour before every retry), so we built something which overcomes it.

### Oh God no, Windows?!

<div class="alignleft" ><img src="/media/ohgodno.jpg" alt="Oh God no" class="noborder"></div>

It's not a big surprise that Azure is running on top of Windows, it's a Microsoft cloud at the end of a day. I know a lot of PHP developers feel very negative about Microsoft and Windows specifically. Well, Internet Explorer 6 specifically, but Windows is not better either. But that is something what you would care if this was an infrastructure service.

Azure+ is Platform as a Service or [PaaS](http://en.wikipedia.org/wiki/Platform_as_a_service) in short. What that means is that you deploy apps to a cloud black box and the infrastructure it is running is completely irrelevant to you. There is more work to be completed to making it truly PaaS, but our goal is to make deploying to this service completely headache-free and to just make everything work\*.

Important fact to note, this is not developed under any collaboration or affiliation with Microsoft and thus it's our own decisions on where we'll take it from here. I think PHP support on Windows is as good as on any other OS and all the PHP apps I tried (Zend Framework, Symfony2, Lithium) worked pretty much out of the box.

### Features

<div class="alignright" ><img src="/media/toys.gif" alt="Toys" class="noborder"></div>

First of all, PHP developers start by writing PHP code, because to start learning PHP you only need a Apache installed and that's it. Hack on some code, click refresh and you see the result. That's what PHP is. That's why at least 15 minutes of wait is just something PHP developer wouldn't want to do. We made it faster. How about 5 sec. or less deployment time?

Furthermore, in core we have mechanisms which allows us to support and change PHP configuration and version in the same short time. So you can try different PHP versions in a matter of one mouse click or switch off `display_errors` when your app is ready to live. Currently you can only choose from two PHP versions and error reporting mode, but there is more to come.

Speed of deployments and configuration freedom is a good building base to start with. But there is more baked in, like an API which allows pushing code directly and a service which will pull from a specified Git repository automatically. Right now we are working on adding MySQL support, so you can port pretty much any existing app. It's a great core platform which allows adding new functionality very very easily.

### Reception

<div class="alignleft" ><img src="/media/azureplusisgood.jpg" alt="Azure+ is good" class="noborder"></div>

It was an unbelievable journey so far and we learned insane amount of things about Azure itself and how to make PHP deployments blazing fast. Some things required hours to tackle, but in the end we made sure that our users are never going to have to deal with them. And believe me, there are **a lot** of things you can shoot yourself with when working with Windows.

This is a project which needs feedback and especially from people who know PHP, cloud stack etc. really well. I was running demos and giving access to some people I know and, I think, they were really impressed with the stack. Also because it relies heavily on Microsoft stack, I had spent past two weeks demoing it to a selected group of Microsoft friends and so far reception was amazing. To quote one:

> I think you could single highhandedly revolutionize Azure

I think this is a great achievement for PHP community too, because a lot of the functionality we support is not available in some of the leading services so this should kick their asses a bit. We want to stay competitive and keep pushing the PHP ecosystem further, but when it comes to standards, we'll adopt any upcoming specifications for PHP platforms.

### Conclusion

Currently a group of 15 or so people is actively testing this and is sending us valuable feedback. Nevertheless it's quite close to production-quality service and you'll hear more about it very soon. If you feel like you'd like to test this (completely free of charge) and would be able to provide some good thoughts, feel welcome to write to me. You can find more details about Azure+ [here](http://cloud.webspecies.co.uk/).
