---
title: "September release"
kind: article
created_at: 2009-09-14 17:08
subject: 'livecd'
tags: [ 'september', 'awaiting' ]
---
HI all\!

Working on the liveCDs last week seemed to be quite less problematic than usual\.
I\'m happy to annouce a full rewrite of the mkstage script \(called mkstage2\)\. It is much more reliable and much less complicated, I\'ve also splitted the source files to little separate scripts which work on much lesser data\.

As some of you may have noticed, liveCDs have been uploaded yesterday\. Now, lets get to the stages\: since there\'s automatic rebuild available, it makes no sense releasing the stages along with the liveCDs\. Stages are rebuilt every month and can be found in the [FTP stages directory](ftp://ftp.faskatech.net/stages/)\. As of now, a full rebuild is in progress, so to have fresh stages\. Once the new ones will be ready, the older ones \(stored with the installCDs\) will be deleted, since they only take up space\.

As anticipated in the official thread, acx and acx\-firmware support has been dropped due to the lack of updated releases\. For the very same reason, madwifi\-ng is still left out\.

The feature bumps in this release include\:

* GCC 4\.4\.1
* Glibc 2\.10\.1
* linux\-headers\-2\.6\.30\-r1
* 2\.6\.31 kernel + reiser4

Cheers,
Fabio Scaccabarozzi
