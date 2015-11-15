---
title: 'Random updates'
kind: article
layout: posts
created_at: 2009-07-27 09:22
subject: site
tags:
- minimal
- server
---
Hi all!

First of all sorry for the long absence, it's been a very busy month.
Anyway, I've got a bunch of news:

<!--MORE-->

* Worked on automatic stage rebuilding, all should work as expected. You will find the stages in [experimental FTP directory](ftp://ftp.faskatech.net/experimental/) (now building new stages for i686, later for amd64). Please note that those releases **include** GCC 4.4.x (currently 4.4.1) without graphite deps (that's because I can't tune USE flags during stage1/2/3). They will be built every three weeks and the process gets niced to avoid server slowdowns. You can find the script I'm using in the [mkstage FTP directory](ftp://ftp.faskatech.net/mkstage/).
* General server updates and review
* Created barnyard2 ebuild, available in the main overlay and also submitted to [bugzilla](http://bugs.gentoo.org/279019){:target='_blank'}
* Migrated a number of outdated ebuilds to the outdated overlay
* Updated some ebuild descriptions

Now, lets come to the CDs: I know kernel 2.6.30 has been released and has also seen 3 minor revisions, but I'm waiting for GCC 4.4.x to become at least unstable (drop the hardmask). There are a good number of packages that exhibit problems with GCC 4.4.x, as you can see from the [GCC 4.4 porting bug](http://bugs.gentoo.org/249226){:target='_blank'}. A lot of those bugs have been addressed, but still a few need to be fixed before it can be marked unstable. I hope that for the end of September it will be possible to drop the hardmask, so to be able to release a new version. Meanwhile, you can stick onto the auto-stages and old CDs (that don't lack any vital functionality regarding 2.6.29->2.6.30 bump).

Cheers,  
Fabio Scaccabarozzi
