---
title: 'Experimenting with RAID1 setups on with mdraid and btrfs'
kind: article
layout: post
created_at: 2014-05-03 16:05
subject: guide
tags:
 - server
 - updates
 - guide
 - howto
 - how-to
---
Hi all!  

I anticipated technical articles, well, they take time to produce, and as usual I have little to spare.

Being the first article of this kind, I'd like to talk about a fresh experience I just had with this server. I was running an unusual setup: two disks, one of which contained the OS on a 40Gb partition, and a ZFS pool where I mounted the home partition, libvirt folder etc (960Gb + 1Tb on second disk). The server didn't have any backups, so in case of fatal failure of the disk containing the OS, I would lose every possibility of booting up my extremely customized Gentoo setup. Needless to say, I didn't want this.

I went looking for software RAID1 solutions, possibly booting with little to no customization of the kernel. I found the following:

 * MD (multi-device) RAID1 (with other FS on top, of course)
 * ZFS RAID1
 * Btrfs RAID1

I spent much time documenting myself, I wanted a simple, yet rock-solid and performant solution. I compared each of the ones above, and MD emerged as the winner.
Below is a summary of the key points that helped me decide when comparing the three solutions (keep in mind: simple, rock-solid, performant):

 * MD
    * Pros:
    	* kernel-standard for years
	* rock-solid
	* extremely fast
	* zero management: setup is static and decided at build time
    * Cons:
        * "dumb" solution: requires perfect disk match and has no understanding of the data contained (or better: size will be limited to the smallest partition in a RAID1 array)
	* initramfs required: kernel array autobuilding is discouraged, and as far as I was able to find autoassembling does *not* work for MD metadata after 0.9x
	* rebuild is a major bottleneck, as the disk or partition containing the new disk must be *fully* resynched (1Tb disk needs 1Tb read-write cycle)
	* needs initramfs to assemble the array at boot
	* no data checksumming
 * ZFS
    * Pros:
    	* fast, resilient COW FS with support for additional features
	* fast rebuild, which depends on the data stored on the disk
	* easy management
	* snapshots
	* data checksumming
    * Cons:
    	* external module -> initramfs
	* non-defragmentable
	* only project is ZFSOnLinux, which I deem far from stability
	* ARC cache for caching
	* no support in the OVH netboot media
 * Btrfs
    * Pros:
    	* fast COW FS with support for additional features
	* fast rebuild, which depends on the data stored on the disk
	* snapshots
	* kernel standard cache
	* defragmentable
	* data checksumming
    * Cons:
    	* not-so-resilient FS (yet)
	* hard management when compared to ZFS
	* dated tools on the OVH netboot media
	* requires initramfs for multi-device root partition

Why MD when you have two next-generation filesystems competing for the lead?
The answer is simple, as MD is. It is extremely well documented, extremely performant for daily usage, tightly integrated and tested by kernel developers for *YEARS*, and you don't have to manage it: partition, format, install, done. Nothing more to worry about.
Whilst ZFS is upgradable in-place, allowing to slowly migrate between FS versions safely, it is not supported by the OVH boot media, so it is absolutely off the shelf, I wouldn't be able to perform nor the installation neither the manteinance.
I must admit I tried putting up a multi-device setup with btrfs on the server. It lasted a kernel upgrade. As far as I know, some incompatible bits went in and the whole setup screwed up. Luckily, I was able to recover. Furthermore, while it is assumed that btrfs is somewhat "okay" for daily usage, it is years away from ZFS's absolute reliability when it comes to multi-device setups.
I then tested MD, the "old-gen" solution, and it's working perfectly. The only downside will be a 2-hours manteinance mode for the array to resync if a disk ever fails, but, well, you don't have to do it that often, at least.

Enough with the talk, lets move to the prompt!


## Step 0: planning
Before going for any partitioning, it's wise to use that little extra time you are going to save in the administration of the array to plan the disk space usage.
Personally, I'd delete the boot partition right away, but it's your safety net in case you want to use an exotic filesystem on the root partition. Afterall it's just 200Mb on a n-Tb drive anyway.
I'm going for the usual MBR setup, since my server has 2x1Tb disks. If you're going to partition drives over 2Tb, you *will* need the GPT partition layout, otherwise the space over the 2Tb boundary will not be accessible.
The layout will be the following:

 * 200Mb /boot on ext4 (bootable)
 * 989Gb / on xfs
 * 10Gb swap

Why a so-big partition on a simple volume with xfs, without a splitted /home? This maximizes disk space usage, as there is no wasted space dedicated to a partition that will never fill up.


Cheers,  
Fabio Scaccabarozzi  
