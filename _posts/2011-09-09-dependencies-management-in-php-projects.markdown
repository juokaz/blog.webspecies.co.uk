---
layout: post
title: Dependencies management in PHP projects
author: Juozas
email: juozas@juokaz.com
date: 2011-09-09 13:27:00
tags: [php, dependencies, git, svn, symfony2]
categories:
- PHP
- Tools
---

Rarely a project lives by itself, especially in the days of frameworks. Furthermore, there are a lot of great open source libraries you might want to use to save time. But all of this raises a new problem - how could we manage all those dependencies. Here are some thoughts on this problem and how you might want to solve it; without shooting yourself in a foot. Which is commonly known as [DLL Hell](http://en.wikipedia.org/wiki/DLL_Hell).
 
<!--more-->

Usually SVN or Git integrated external references management tools are used for this. But... Version control systems are not made for managing dependencies.  Period. They can be made to do so, but sooner or later they are going to fail at doing that. This is a fact and there is no way avoiding it, if you don't trust me on this here are some proofs why.

### Version control systems

<div class="alignright" ><img src="/media/stop.gif" alt="Stop" class="noborder"></div>

The most popular one couple years ago was [svn:externals](http://svnbook.red-bean.com/en/1.0/ch07s03.html) for SVN, which is quite similar to [git submodule](http://kernel.org/pub/software/scm/git/docs/git-submodule.html) for GIT. The first obvious problem is that they both only support referencing repositories of the same type, that is you can't include a Git dependency in a SVN project. Which today is a very problematic thing because you might still be using SVN, although not sure why you would be doing so, but a lot of the open source projects have moved on to GitHub. 

If you are fine with the above, I think you should be quite quickly annoyed by the fact that those sub-folders you are automatically populating are in fact full checkouts by themselves, thus not read-only. Which potentially is a very risky design characteristic, because most of the time you aren't supposed to commit from those checkouts, even if you have changed something there.   

Git users might be disappointed to know that submodules do not support partial checkouts, that is you can only checkout full repositories. This works fine most of the times, but quite often you'd like to checkout a sub-folder of the repository (for example only library folder from Zend Framework). There is a solution for that called [subtree merge](http://progit.org/book/ch6-7.html), but I find it way too complicated for my liking and I only have used it a handful of times. 

### How far you want to go

<div class="alignright" ><img src="/media/space.gif" alt="Space" class="noborder"></div>

The most obvious use of external dependencies is to get a copy of the framework you are using. This is quite a simple task because it can even be solved by just downloading a copy of the framework and sticking it in the project folder. Easy enough to manage, although not ideal. If you have less than say 5 of such dependencies then any way you choose to manage them is going to be fine. As long as they don't have dependencies themselves... 

Dependencies actually are much more complicated than that. If you are using truly componentized libraries, those by themselves are going to have some dependencies. This introduces the [transitive dependencies](http://en.wikipedia.org/wiki/Transitive_dependency) problem which you can't easily solve. This is not such a big deal for PHP projects, because the biggest place where such libraries exist is PEAR.net and the tools there will help you with that. Anyhow, keep this in mind.

As you can see depending on what sort of external code you are trying pull in there are different problems attached to it. From my experience simple management of the dependencies is enough, because I'm yet to see a big number of libraries having clearly defined dependencies. So unless this changes soon, I just use the simplest tools available. 

### Tools made for this

<div class="alignright" ><img src="/media/tools.jpg" alt="Tools" class="noborder"></div>

One of the best known tools is [Apache Maven](http://maven.apache.org/), especially if you have Java experience. It does everything you'd want from a dependency manager and probably more, but having used it for couple projects I think it's overcomplicating what I would need for our projects. Maybe because I haven't worked on projects complicated enough, but more likely because I just don't find tools like this attractive and valuable. 

You might also want to use [PEAR](http://pear.php.net/index.php) for dependencies management, although it requires external libraries to be stored in PEAR repositories. Similarly there is the [composer](http://github.com/composer/composer) project which tries to solve a lot of dependencies problems and can resolve them from various different sources, but it still seems to be in development and I haven't played with it enough. I think composer might be the one to watch.

Symfony2 has an interesting approach of just having a [deps](https://github.com/symfony/symfony-standard/blob/master/deps) file which is used to define where all the dependencies are and where to place them. Think of it as a very light build recipe. Following a similar approach I have extended it and added support for different repository types and sub-repository checkouts. One script `./bin/vendors install` to run looks great to me.

### Things you shouldn't forget

<div class="alignright" ><img src="/media/remember.jpg" alt="Remember" class="noborder"></div>

With the growing popularity of Symfony2, there are more and more bundles floating around on GitHub. However I just recently had a case where a new developer checked out a project and it wasn't working completely. Apparently in couple weeks of time one of the bundles was refactored resulting in all previous integrations completely failing. 

It was my stupidity of not locking in to a specific revision of the bundle (which you can do using the deps.lock file), but it is likely that you will repeat this mistake too. The fact you need to understand is that most of the time you will be pulling 3rd party dependencies which you have no control of and if you depend on them heavily, which you probably are, you need to know a specific version you want to use. Point it to a stable version if they have one, because it's extremely bad to just point your reference to a master branch.

Furthermore, a library can go away completely. If it's hosted in a obscure small website you just found, month down the road there could be no trace of it anymore. Even GitHub doesn't protect from this - repository can be deleted and will be gone forever. So you need to make a choice - how much do you trust the authors - and preferably backup the source code locally (or setup a mirror repository). 

### Conclusion

One way or another you will have to solve this problem. I'd say the easiest way to start with and have some room to grow is to integrate this with your build scripts, even as a simple bash script. Don't try to reinvent the wheel if you need something more sophisticated - there exists working tools already, so just give some of them a go. Just make sure you know what version you want to depend on and have some safety nets against disappearing sources.
