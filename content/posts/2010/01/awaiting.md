---
title: 'Awaiting...'
kind: article
created_at: 2010-01-24 18:30
subject: livecd
tags:
- awaiting
- server
---
Hi all\!

Four months have passed since last update, I shall shortly summarize what happened during this time\:

* A lot of updates to the server\: kernel \-> 2\.6\.32 + grsec, glibc 2\.11, gcc 4\.4
* Now running on ~amd64 gentoo
* Removal of a lot of cruft from the server\: unused users, applications, databases, configuration files etc
* Shifted all partitions to XFS filesystem to allow much lesser fragmentation and much more reliability \(compared to ext3\); I personally don\'t really care if one or two temporary files get zero\-ed out upon power failure \(which is extremely unlikely to happen anyway\)
* Set up an automatic fully incremental backup script for the whole system based on app\-backup/rdiff\-backup; I will release it in few days, time needed to study a little and remove the internal references to the paths\. Its name is \"rdiff2ftp\" because once done, it shifts everything to the FTP backup service granted by OVH
* Now running the BOINC platform to support @home distributed computing programs, specifically\: [SETI@home](SETI@home) and [MilkyWay@home](MilkyWay@home); they are both sharing the same single\-core processor
* Re\-design the setup of the directories served by Apache webserver, which allows for much easier management of Joomla and does, in general, improve security
* Blogs were shut down, no word was ever written here anyway due to lack of interest and time; if I\'ll ever need to open up one again, I know it can be easily done
* Added the link for the official forum thread for the liveCDs in the dedicated section
* Added the PayPal donation button to the site

This summary covers everything that\'s been done to the server\. If you ever noticed some slowdowns or out\-of\-service conditions, one of these tasks was being executed\.

Now, some information about the next release\: as stated in the [official thread@gentoo forums](http://forums.gentoo.org/viewtopic-t-677993-highlight-.html), there is currently no reiser4 patch for 2\.6\.32 kernel available and I\'m waiting for the rebuild time to diff it from zen\-sources \(hopefully working\)\. If I\'m unable to diff it I will stick with 2\.6\.31, though I would regret to leave out the indipendent block\-device queueing introduced in 2\.6\.32 series\. That would be a great performance boost for the disk operations usually done from a liveCD\.
Likewhoa contacted me for testing his JustBOOT liveCD generator script, I will test it without a doubt during the building of the release\.
I\'m also planning to wait some more time for the release\: about the 15th of March should be a reasonable date\. The fact is that next week university exams begin and I\'ll be forced to stay away from the machines for a while\. This will also provide some more time to debug and test the reiser4 code in zen\-sources, which should allow for a smoother diff/transaction\.

Cheers,
Fabio Scaccabarozzi
