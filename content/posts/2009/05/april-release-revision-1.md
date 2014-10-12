---
title: 'April release revision 1'
kind: article
layout: posts
created_at: 2009-05-24 20:32
subject: livecd
tags:
- minimal
- april
---
Hi, all!

I'm happy to announce the revision bump of the April release.

I've been following a request from kernelOfTruth and Jupiter1TX to have the USB and HID modules builtin, so to have USB keyboards properly working (genkernel bug?) and that has been done (thanks goes out to kernelOfTruth and Jupiter1TX for the testing the betas). You can read about this on the [Official thread @Gentoo Forums](http://forums.gentoo.org/viewtopic-t-841256.html){:target='_blank'}.
Another important thing, which may pass unobserved, is the update to TrueCrypt 6.2a. Thanks to the the trustees council on May 17th, the ebuild has been unmasked and upgraded, and then included in the release :-)

<!--MORE-->

One thing's still to fix. Please pay attention when downloading by accessing FTP directly: though the suffix is "-r1" the CDs are named as usual, and the stages are the pure exact copy from the 20090407 one. I'm working on automatic stage rebuild for both archs, that should (hopefully) completely obsolete the need to release the CDs along with the stages. I was thinking of a three-week based rotation. I've written the script but I've got some little issues with the grsec patch blocking access to the temporary directories and the automatic e-mailing. Will notify soon =)

Enjoy!

Cheers,
Neo2
