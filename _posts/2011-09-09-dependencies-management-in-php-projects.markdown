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

<!--more-->

### Version control systems

Version control systems are not made for managing dependencies. Period. They can be made to do so, but sooner or later they are going to fail at doing that. 

The most popular one couple years ago was [svn:externals](http://svnbook.red-bean.com/en/1.0/ch07s03.html) for SVN, which is quite similar to [git submodule](http://kernel.org/pub/software/scm/git/docs/git-submodule.html) for GIT. First of all the obvious problem exist that they both only support referencing repositories of the same type, that is you can’t include a Git dependency in a SVN project. Which today is a very problematic thing because you might still be using SVN, although not sure why you would be doing so, but a lot of the open source projects have moved on to GitHub. 

If you are fine with the above, I think you should be quite quickly annoyed by the fact that those sub-folders you are automatically populating are in fact full checkouts by themselves, thus not read-only. Which is potentially a very risky design characteristic, because almost never are you supposed to commit from those checkouts, even if you have changed something there.   

Git users might be disappointed to know that submodules do not support partial checkouts, that is you can only checkout full repositories. This works fine most of the times, but quite often you’d like to checkout a sub-folder of the repository (for example only library folder from Zend Framework). There is a solution for that called [subtree merge](http://progit.org/book/ch6-7.html), but I find it way too complicated for my liking and only have used a handful of times. 

### Tools made for this

One of the best known tools is [Apache Maven](http://maven.apache.org/), especially if you had Java experience. It does everything you’d want from a dependency manager and probably more, but having used it for couple projects I think it’s overcomplicating what I would need for our projects. 

### Conclusion

