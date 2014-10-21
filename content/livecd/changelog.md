---
title: Changelog
kind: livecd
layout: pages_with_sidebar
---

{::options parse_block_html="true" /}

<article>
## 9th release (2013-02-07)
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
</article>

<article>
## 8th release (2011-03-04)
* 2.6.37.2 kernel + reiser4
* gcc-4.5.2
* glibc 2.13-r1
* linux-headers 2.6.36.1
* Drivers:
    * NTFS in-kernel driver disabled, only ntfs3g support is now available
* Other notes:
    * full ~arch build (instead of selective unmasking)
    * dev-util/metro is used for building the stages (instead of catalyst)
    * final strip phase disabled (except for /usr/portage and /usr/src): fully working stage3 setup + additional packages (about +100Mb per-CD)
    * versioning modified: now the release gets versioned with the release date
</article>

<article>
## 7th release (2010-03-16)
* 2.6.33.1 kernel + reiser4
* gcc 4.4.3
* glibc 2.11-r1
* linux-headers 2.6.33
* TrueCrypt 6.3a
* Added packages:
    * app-arch/pbzip2
    * app-arch/xz-utils
    * app-misc/dtach
    * app-misc/screen
    * app-misc/secure-delete
    * sys-process/acct
    * sys-process/atop
* Drivers:
    * Re-added acx, acx-firmware, madwifi-ng, madwifi-ng-tools
* Other notes:
    * btrfs-progs is a live snapshot and contains some fixes for the subvolume management (as far as I know, subvolume support is still incomplete)
</article>

<article>
## 6th release (2009-09-14)
* 2.6.31 kernel + reiser4
* gcc 4.4.1
* glibc-2.10.1
* linux-headers-2.6.30-r1
* TrueCrypt 6.2a
* "Suspended" drivers:
    * acx, acx-firmware
</article>

<article>
## 5th release (2009-04-07)
* 2.6.29.1 kernel + reiser4
* gcc 4.3.3-r2
* glibc-2.9_p20081201-r2
* linux-headers-2.6.28-r1
* TrueCrypt 6.0a
* Added Packages:
    * sys-fs/xfsdump
    * sys-fs/ecryptfs-utils
    * sys-fs/btrfs-progs
* "Suspended" drivers:
    * madwifi-ng (modded the ebuild to compile against 2.6.29.1, but the new kernel release has changed internal structures -> avoiding to fix with broken hand-made patches)
    * madwifi-ng-tools (without madwifi-ng makes no sense)
* Other notes:
    * btrfs has been included, along with the associated btrfs-progs package
</article>

<article>
## 4th release (2008-12-20)
* 2.6.27.10 kernel + reiser4
* gcc 4.3.2
* glibc-2.9_p20081201
* linux-headers-2.6.27-r2
* Added packages:
    * app-admin/hddtemp
    * app-admin/testdisk
    * net-analyzer/bmon
    * net-analyzer/packit
    * net-analzer/tcptrack
    * net-wireless/wavemon
    * sys-apps/pv
    * sys-apps/smartmontools
    * sys-process/iotop
* Added drivers:
    * madwifi-ng
    * madwifi-ng-tools
* Removed drivers:
    * ipw3945: latest version does not compile against 2.6.27, the driver has been deprecated in favor of iwlwifi driver mantained by the kernel team
* Other notes
    * keymap selection at boot has been fixed: it was my fault when writing the spec files, I did not realize the connection between the keymaps/consolefont init scripts and the impossibility to keep the selected keymap, that is done earlier at boot (even before rc scripts)
    * madwifi-ng has been reintegrated upon request
</article>

<article>
## 3rd release (2008-09-15)
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
</article>

<article>
## 2nd release (2008-06-16)
* 2.6.25-reiser4-r5 (based upon 2.6.25.6, don't let the name mislead you)
* gcc 4.3.1
* glibc-2.7-r2
* linux-headers-2.6.25-r4
* modularized **whole** PATA/SATA stuff (pay attention to new drivers naming scheme if you can't find your drive)
* added all new drivers that have been included in the kernel
* madwifi-ng does work fine (tested)
* Added packages:
    * net-analyzer/iftop
    * sys-power/powertop
    * sys-process/latencytop
* Added drivers:
    * madwifi-ng (latest unstable)
    * madwifi-ng-tools (latest unstable)
</article>

<article>
## 1st release (2008-03-23)
* Added drivers:
    * net-wireless/acx
    * net-wireless/acx-firmware (custom ov. ebuild)
    * sys-fs/dmraid
    * sys-fs/ntfs3g (latest unstable)
* Added packages:
    * app-crypt/truecrypt
    * app-misc/wipe
    * net-misc/rsync
    * net-wireless/ndiswrapper
    * sys-apps/usbutils
    * sys-fs/hfsutils
    * sys-fs/parted
    * sys-process/htop
* SCSI emulation, SCSI support and all RAID types are builtin (of course with raid targets support)
* reiser4-sources 2.6.24-r4
* gcc 4.2.3 (unstable)
</article>
