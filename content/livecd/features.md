---
kind: livecd
layout: livecd
---
#### Features
LiveCD releases are based off Gentoo Minimal LiveCDs, they feature:
* dev-lang/perl
* app-crypt/truecrypt
* full update of system packages 
* reiser4-sources (with custom power patches) && reiser4progs 
* latest unstable gcc
* latest unstable glibc
* 2008.0 pure profile
* wider hardware support (mostly PATA/SATA controllers and wireless cards): if the kernel being used for the new release supports new hardware it will be included in the next release as well (ath5k etc...)
* various extra packages

Some have already asked for X/graphics inclusion, my answer has always been "no" for the following reasons:
* minimal liveCDs weigh ~100Mb, full liveCDs ~700Mb or more (less pain for users, faster availability)
* troubleshooting the base profile with basic settings it's a matter of hours, whereas troubleshooting >700 packages it's a matter of weeks (I don't have such time)
* I don't have enough CPU power available to make a big release available to the public in my few spare weeks (2~3 weeks every 3~4 months)
