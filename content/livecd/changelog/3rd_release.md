---
title: 3rd release
date: 2008-09-15
kind: changelog
---
* 2.6.26.5 kernel + reiser4
* gcc 4.3.1-r1
* glibc-2.7-r2
* linux-headers-2.6.26
* Added packages:
    * app-arch/p7zip
    * sys-boot/grub
    * sys-power/acpitool
* Removed drivers:
    * madwifi-ng / madwifi-ng-tools (ath5k is enough mature and madwifi-ng-0.9.4 doesn't compile against 2.6.26)
* Changes over default configuration:
    * e2fsprogs 1.41.1 (with subsequent dependencies: e2fslibs, com_err, ss)
* Other notes:
    * e2fsprogs is included also in stage3, that means you'll have to unmask that also to prevent downgrades (deps also)
