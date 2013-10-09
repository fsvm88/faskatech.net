---
title: 'New release: 2011-03-06'
kind: article
layout: post
created_at: 2011-03-06 14:22
subject: livecd
tags:
 - 2011
 - march
 - metro
 - changes
 - server
 - updates
---
Hi all\!

The new release if finally out\! It\'s been almost an year since the latest release\.
The long time since the last update brings some interesting news for you\:

* kernel 2\.6\.37\.2 with reiser4 patches
* gcc\-4\.5\.2, glibc\-2\.13\-r1, linux\-headers\-2\.6\.36\.1
* NTFS kernel module has been disabled in favor of external ntfs3g to avoid conflicts \(ntfs3g has much much wider NTFS support than in\-kernel module anyway\)
* everything is built from ~arch now\. This is to avoid a lot of work in terms of troubleshooting\. Building from arch and unmasking only certain packages means that some others, at some point, won\'t build, thus requiring additional unmaskings in a never ending cycle\.
* everything is built using metro, thus the stages are compressed using xz\-utils\. The distributed stages are now built from ~arch, of course
* the final strip phase has been disabled\: this means that apart from /usr/portage and /usr/src you have now a fully working stage3 setup \+  additional goodies\. The one I like most is having man pages available\. Teorethically, you can also compile source files or entire packages directly from the liveCD\. I haven\'t tested this possibility though\. This comes at the cost of about \+100Mb for each CD, but I think it is a fair price\.
* the versioning has changed\: now both liveCDs and stages are marked with the release date \(no more unique 2008\.0 naming\)



Along with the new release I delivered some updates to the server\:

* \(lighttpd \+ postgresql \+ drupal\) instead of \(apache2 \+ mysql \+ joomla\)
* 2\.6\.37\.2 kernel \+ grsecurity \+ ck2 patches
* switched to hardened profile
* migrated root filesystem to ext4
* general configuration cleanups
* packed old releases in in a unique 2Gb file\. Nobody should be using these anymore\. I strongly recommend to only use the latest release available\.

Hoping that all of this will result in a more pleasant experience, I invite you to download and test the latest liveCDs, already available from the download page\.

Cheers,
Fabio Scaccabarozzi
