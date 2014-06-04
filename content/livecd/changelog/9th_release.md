---
title: 9th release
date: 2013-02-07
kind: changelog
---
* 3.11.10 kernel + reiser4 patch
* gcc-4.8.2
* glibc 2.17
* linux-headers 3.12
* Drivers:
    * added zfs filesystem support
    * ndiswrapper suspended/removed: not compatible with linux 3.11 as of build date (still 1.58 in portage)
    * gfs2-utils: libdlm generates conflicts with kernel headers at compile-time
* Other notes:
    * back to selective unmask of packages (no more ~arch)
	* amd64 version only: less troubleshooting time, may re-add x86 version upon request
