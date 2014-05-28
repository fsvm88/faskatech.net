---
title: 'March release 2010 - Happy birthday!'
kind: article
layout: posts
created_at: 2010-03-19 14:59
subject: livecd
tags:
 - march
 - livecd
 - release
---
Hi all\!

The new release is finally out\!

It features kernel 2\.6\.33\.1 \+ glibc 2\.11-r1\. All the \"suspended\" drivers were reintegrated as the latest versions would compile cleanly\. Some packages have been added, most notably pbzip2 to make bzip2 scale on multicore systems\. Btrfs-progs has been included as a live ebuild, to allow some fixes for the subvolume management system to be included\.
<!--MORE-->

If you notice any regression \(eg\. something that was working is now non-working\) please report as soon as possible\. I had to rewrite the spec files \(lost the previous ones\) and I was able to restore them\. I also did extensive regression testing concerning the additional packages and the key features, but of course something may have slipped through\.

I would also like to thank all the supporters and the people out there \(and especially the ones at Gentoo Forums\!\) for both the appreciation and the critics, we have made it two years far \=\)

Cheers,
Fabio Scaccabarozzi
