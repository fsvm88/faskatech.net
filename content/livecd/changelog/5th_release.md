---
title: 5th release
date: 2009-04-07
kind: changelog
---
* 2\.6\.29\.1 kernel \+ reiser4
* gcc 4\.3\.3\-r2
* glibc\-2\.9\_p20081201\-r2
* linux\-headers\-2\.6\.28\-r1
* TrueCrypt 6\.0a
* Added Packages\:
    * sys\-fs/xfsdump
    * sys\-fs/ecryptfs\-utils
    * sys\-fs/btrfs\-progs
* \"Suspended\" drivers\:
    * madwifi\-ng (modded the ebuild to compile against 2\.6\.29\.1, but the new kernel release has changed internal structures \-\> avoiding to fix with broken hand\-made patches)
    * madwifi\-ng\-tools (without madwifi\-ng makes no sense)
* Other notes\:
    * btrfs has been included, along with the associated btrfs\-progs package
