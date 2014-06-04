---
title: 'Two years later'
kind: article
layout: posts
created_at: 2013-12-11 19:10
subject: livecd
tags:
 - december
 - release
 - livecd
 - changes
 - server
 - updates
---
Hi all!  

It's been more than two years since the last post.  
Some of you may have thought the project was dead. Well, it was in fact suspended.  
There are multiple reasons, the top one being the lack of time to properly follow the project. It takes a while to build and mantain the releases and the process is not error-free at all (rather, quite the opposite). Furthermore, for some time the destiny of the Reiser4 patch has been uncertain: between March 2011 and November 2011 there were no updates on the only mailing list where the patch was published, and development seemed to have ceased.  
<!--MORE-->

In January 2013 I decided I would get back to my projects and commit to some more blogging.  
I rented a new, more powerful server and dismissed the old one. To my astonishment the website would still perform in a sluggish manner. After some optimizations to the existing setup, all to no end, I figured I needed some other way to boost it. While working at my new job I discovered static website generation and the Bootstrap framework, so I made up from scratch this new website with nanoc and Bootstrap. Needless to say, the only performance limit now is the bandwidth of the reader. And that's about how Drupal+PostgreSQL+PHP were thrown out the window.  

As for the liveCD project, some really important news:  

* unless there is demand for the x86 build, from now on **only the amd64 build will be released and updated**: I can't remember having booted a 32-bit only PC in the last 3 years, it has the same burden of the amd64 build, plus some drivers/packages occasionally won't compile (requiring manual intervention at each build)  
* I reverted to building the stages with **catalyst**: metro simply doesn't cope well with unstable gentoo, and I don't have time to debug it  
* I reverted to arch + specific unmasks: easier to mantain, less packages failing for obscure reasons  

  
  
And there goes the Changelog for this release (R2013-12-07):  

* 3.11.10 kernel + reiser4 patch  
* gcc-4.8.2  
* glibc 2.17  
* linux-headers 3.12  
* added ZFS filesystem support, ndiswrapper suspended/removed, gfs2-utils suspended  

See the full [Changelog](/livecd/changelog/) for additional details.  

Stay in tune for the new technical articles ;-)  


Cheers,  
Fabio Scaccabarozzi  
