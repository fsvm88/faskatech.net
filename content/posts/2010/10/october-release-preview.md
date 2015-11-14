---
title: 'October release preview'
kind: article
layout: posts
created_at: 2010-10-09 13:37
subject: livecd
tags:
- metro
- preview
---
Hi all!

Some of you may have noticed that I updated the "Release Schedule" page a while ago.
I intended to make a release available before the 30th of September, but I decided to postpone it for some reasons:

* 2.6.36 is coming around
* GCC 4.5.1 has been added to the tree
* a new tool for building stages has been released and gained a lot of popularity recently: [Metro](http://www.funtoo.org/en/metro/tutorial/){:target='_blank'}
While GCC 4.5.1 still has some [problems](http://bugs.gentoo.org/show_bug.cgi?id=296658){:target='_blank'} with some packages (I'd consider only grub-9999 a showstopper), I consider it to be fairly stable for a non mission-critical system. Therefore, I'm really considering the opportunity to make it the default compiler for this release.  

<!--MORE-->

The Glibc version will be the 2.12.1-r1 unless a newer one shows up (with 2.6.35 headers).

In the meanwhile, I tested Metro as an alternative to Catalyst for stage building. I will be switching the stage rebuild infrastructure on the server as soon as the bug with libxml2 gets fixed (which prevents stage3 from building correctly). Metro is superb when compared to Catalyst. It allows to set per-package flags, features automatic renaming according to the current date and allows to use only one spec file shared between all architectures, which means that you can write one single file only once and you're ready to build all stages for all architectures for any date. Basically it allows to tune every single parameter in a very flexible manner.

As for the kernel, Linus announced that -rc7 is highly likely to be the last release candidate before the kernel will be declared stable. Provided this announcement was made last Wednesday, I hope that this Monday or at worst the next one (18th) we will see 2.6.36 as the stable kernel.

Lately I've been experimenting a lot also with BFS, BFQ and the ck patchset on my desktop system. I found the responsiveness improvements amazing, which is why I'd like to ship also these features with the next release.

I'm also going to include some tools for hdd/filesystem backup/restoration such as ddrescue (for hdd 1:1 copy in case of hdd failure), safecopy, dd-rhelp and rdiff-backup which helped me a lot during a failure with one of my drives. The last package depends on python, which is why at least python:2.6 will be spared from the final unmerge phase, making it available as another way of using simple python scripts (which do not depend on other python extensions/libraries).

Accounting about a week for the patches to catch up (most notably the Reiser4 ones), I expect to have the release ready before the end of October.

I would appreciate feedback on these decisions because a few things are going to change in this release and not everybody may welcome them. Please have a stop at the [official thread at gentoo.org](http://forums.gentoo.org/viewtopic-t-841256.html){:target='_blank'} if you are interested in the topic.

Cheers,  
Fabio Scaccabarozzi
