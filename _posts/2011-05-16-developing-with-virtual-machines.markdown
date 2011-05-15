---
layout: post
title: Developing with Virtual Machines
author: Juozas
email: juozas@juokaz.com
date: 2011-05-16 14:35:13
tags: [virtualbox, vm]
categories:
- Tools
---

There are millions of articles on how to setup LAMP setup on your own machine to allow developing websites locally. I think this is a wrong approach as running server programs in one’s computer creates a lot of potential problems. Better approach for this would be to use Virtual Machines as they allow bigger flexibility and fewer problems when something goes wrong. 

Of course you probably don’t want to do it if you are only working on one project or you are just starting your carrier as especially at first it will feel kind of weird. However for people like me who work on a dozen different projects throughout the week it’s just so much better. Hopefully after reading this you will rethink your setup. 

<!--more-->

### Performance

Having a VM for web server first of all makes your computer boot much faster. I was getting really frustrated at some point because I had so many different server components installed in my main laptop that it was just unusable. Web server with a dozen of websites, database servers, monitoring tools etc. all of this was just too much. 

Processors and other hardware nowadays have really good support for virtualization (you can read more about it in Wikipedia) so there is no real performance drawback.  Just make sure you have enough RAM to run multiple OSes and as much as possible cores in your processor for the load to be spread out.  Not surprisingly only install systems without graphical UI, for example install Ubuntu Server without `ubuntu-desktop` package, this will save a lot of resources. 

### Advantages

Once all of this is moved to a VM this problem is solved immediately. What is more, it makes it easier to reinstall machines and migrate them. Not only you can move VMs between different machines (in most cases this works) so you can have same setup for testing on a laptop and on a main computer, but in case you need to reinstall anything you are safer not to screw up the whole system.

Obviously **decoupling** of testing environments from an actual machine also makes it possible to have different environments to test different things. For example I have one VM with Windows server and one with Ubuntu and both of them act as web servers. This allows testing same applications with different configurations very easily. 

Furthermore you can test load balancing, database replication and other things which require multiple servers really easy. And with a help of VM software and tools available in OS one can also simulate network latency, dropped packages and bandwidth. Some of those things you can’t even test on real hardware (like network performance) and VMs just work great for that, it’s only a matter of using right tools. 

### VirtualBox

For VMs I use VirtualBox because it’s free, works really well and supports all the features I might need. My setup is quite trivial but has worked really well so far - all VMs are in a Host-Only network with static IPs. So I can access them from a computer or from any other VM by IP like `156.2.2.101`, but they are not visible from other computers in a network while still having internet connection from a second network connection in Bridge mode. 

Sharing files with VirtualBox is really easy at it supports shared folders. Shared folders are exactly what they stand for - any folder in computer becomes a visible partition (Windows) or device (Linux) which then you can map to wherever you want. To support this you need to install guest additions in each VM’s as you need a special kernel module for shared folders. I haven’t yet figured out how to install it without full additions, so let me know if you have any ideas. 

### Better setup

However I don’t use shared folders that often as I have build scripts for deployment. I believe this is just a better as I don’t want to map my project folders to be accessed by web servers as they might create some cache files or modify them in any other way which would be really bad. So I just execute:

{% highlight bash %}
ant testing
{% endhighlight %}

And it deploys application to assigned VM. To make this work well I have my public key deployed to all of the VMs so I can connect to them without using a password. Also I have mapped app IP addresses to specific hosts like doctrine.dev, which allow to connect to a VM as easily as

{% highlight bash %}
ssh doctrine.dev
{% endhighlight %}

Or to access a website hosted in that server

{% highlight bash %}
http://doctrine.dev/
{% endhighlight %}

Once you have done this, you completely forget the fact that it’s VM you are using. Because I use Ubuntu I have all VMs open in a separate workplace which I don’t use for anything else. And I “talk” to them like with any other server - using SSH. Yet another decoupling point - all the build scripts you write can be used for staging/production server later as you would be accessing them in a same way. 

### Conclusion

I can’t be happier for this switch as it finally allowed using my computer not only for development. If VMs are not started there is nothing waiting in system processes. The amount of flexibility and features is just great and much bigger than initial hassle to get the setup working. 