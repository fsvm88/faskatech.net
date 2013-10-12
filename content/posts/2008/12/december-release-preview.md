---
title: 'December release preview'
kind: article
layout: post
created_at: 2008-12-14 11:08
subject: livecd
tags:
- december
- 2008
- preview
---
Hi all! As you\'ve seen the template has been changed again\. This is the ultimate solution for clearer reading \(this one scales to the optimal page width\)\. Also, some sections have been reorganized \(look, font size\) and the overlay section has been completed\.

I\'m currently working on the new release\. My will was to update python\+portage to the latest version \(2\.5\.2\-rX \+ 2\.2\_rcY\) but while this works fine on the amd64 arch, on the i686 one there seems to be some ordering issue concealing ncurses/nano when emerging that leads to stage3 failure\. If this doesn\'t get fixed before the 22nd of December in portage 2\.2 I\'ll drop those two features and stick with the mainline ones; since portage 2\.1\.6\.1 is already out I may move to that one instead \(will check the ChangeLog for differences, if there\'s something one may want from the \"stable\" setup\)\.
Other major \(currently working&included\) updates include\: gcc\-4\.3\.2, linux\-headers\-2\.6\.27\-r2 and the latest glibc snapshot, currently 2\.8\_p20080602\-r1, this afternoon\'s snapshot will use 2\.9\_p20081201\. Glibc 2\.8 and 2\.9 include simple memory optimizations that provide heavy performance boosts \(before 2\.8 I used to compile glibc in ~40 minutes, now I can compile 2\.9 in ~25mins\)\. I\'m also waiting for 2\.6\.28 kernel to come out \(will be soon I guess, since we\'re at 2\.6\.27\.8\)\.

Current feature requests include\:

* madwifi\-ng reintegration 
* iotop, smartmontools, hddtemp & some more monitoring tools

Talking of the server, I\'m currently setting up email through postfix, this will require some time\. Once that is done I will setup a submission form\.

Cheers,
Fabio Scaccabarozzi
