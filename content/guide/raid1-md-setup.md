---
title: 'How-to: RAID1 with MD on two identical disks'
kind: guide
layout: posts
created_at: 2014-05-03 16:05
tags:
 - server
 - updates
 - guide
 - howto
 - how-to
---
Being the first guide of this kind, I'd like to talk about a fresh experience I just had with this server. I was running an unusual setup: two disks, one of which contained the OS on a 40Gb partition, and a ZFS pool where I mounted the home partition, libvirt folder etc (960Gb + 1Tb on second disk). The server didn't have any backups, so in case of fatal failure of the disk containing the OS, I would lose every possibility of booting up my extremely customized Gentoo setup. Needless to say, I couldn't just wait hoping it would never happen.

I went looking for software RAID1 solutions, possibly booting with little to no customization of the kernel. I found the following:

 * MD (multi-device) RAID1
 * ZFS RAID1
 * Btrfs RAID1

I spent much time documenting myself, I wanted a simple, yet rock-solid and performant solution. I compared each of the ones above, and MD emerged as the winner.  
Below is a summary of the key points that helped me decide when comparing the three solutions (keep in mind: simple, rock-solid, performant):

 * MD
    * Pros:
        * kernel-standard for years
        * rock-solid
        * extremely fast
        * zero management: setup is static and decided at assemble time
    * Cons:
        * "dumb" solution: requires perfect disk match and has no understanding of the data contained (or better: size will be limited to the smallest partition in a RAID1 array)
	* initramfs required: kernel array autobuilding is discouraged, and as far as I was able to find autoassembling does **not** work for MD metadata after 0.9x
	* rebuild is a major bottleneck, as the disk or partition containing the new disk must be **fully** resynched (1Tb disk needs 1Tb read-write cycle, though the array should be usable in the meantime)
	* needs initramfs to assemble the array at boot
	* no data checksumming
 * ZFS
    * Pros:
        * fast, resilient COW FS with support for many additional features
        * fast rebuild, which depends on the data stored on the disk
        * easy management
        * snapshots
        * data checksumming
        * ARC cache for advanced data caching
    * Cons:
        * external module -> initramfs
        * non-defragmentable
        * only project is ZFSOnLinux, which I deem far from rock-solid (although usable)
        * ARC cache for advanced data caching
        * **no support in the OVH netboot media**
 * Btrfs
    * Pros:
        * fast COW FS with support for additional features
        * fast rebuild, which depends on the data stored on the disk
        * snapshots
        * kernel standard cache (as opposed to ARC)
        * defragmentable
        * data checksumming
    * Cons:
        * not-so-resilient FS (yet)
        * hard management when compared to ZFS
        * dated tools on the OVH netboot media
        * requires initramfs for multi-device root partition

**Q:** *Why MD when you have two next-generation filesystems competing for the lead?*  
**A:** The answer is simple, as MD is. It is extremely well documented, extremely performant for daily usage, tightly integrated and tested by kernel developers for **YEARS**, and you don't have to manage it: partition, format, install, done. Nothing more to worry about.
Whilst ZFS is upgradable in-place, allowing to slowly migrate between FS versions safely, *it is not supported by the OVH boot media, so it is absolutely off the shelf*, I wouldn't be able to perform neither the installation nor the manteinance.
I must admit I tried putting up a multi-device setup with btrfs on the server **without** initramfs, using a custom patch to support btrfs device detection at boot time. It lasted a kernel upgrade. As far as I know, some incompatible bits went in and the whole setup screwed up. Luckily, I was able to recover. Furthermore, while it is assumed that btrfs is somewhat "okay" for daily usage, it is **years away** from ZFS's reliability when it comes to multi-device setups.
I then tested MD, the "old-gen" solution, and it's working perfectly. The only downside will be a 2-hours manteinance mode for the array to resync if a disk ever fails, but, well, you don't have to do it that often, at least.

Enough with the talk, lets move to the prompt!


### Step 0: planning
Before going for any partitioning, it's wise to use that little extra time you are going to save in the administration of the array to plan the disk space usage.  
Personally, I'd delete the boot partition right away, but it's your safety net in case you want to use an exotic filesystem on the root partition. Afterall it's just 200Mb on a n-Tb drive anyway.  
  
I'm going for the usual MBR setup, since my server has 2x1Tb disks. If you're going to partition drives over 2Tb, you *will* need the GPT partition layout, otherwise the space over the 2Tb boundary will not be accessible.

The layout will be the following:

 * 200Mb /boot on ext4 (bootable)
 * 989Gb / on xfs
 * 10Gb swap

Points worth some words:

**Q:** *Why a so-big partition on a simple volume with xfs, without a splitted /home?*  
**A:** This maximizes disk space usage, as there is no wasted space dedicated to a partition that will never fill up (I'm talking of the root one). As a linux user, this is one of the thougher decisions you have to make. While usually the /home partition is separated from the root one because of backup/data persistence/security issues, you will find yourself over or under provisioning the latter, due to the fact that not all runtime files created by the processes running on your server will allow to relocate their data easily, or conversely, due to the fact that your root is mostly static and never changes in size. This key point is where btrfs and ZFS win over any current filesystem: they allow to create a pool of space that can be easily split in subvolumes, allowing to efficiently manage all the available space without sacrificing data isolation.

**Q:** *Why a so-big swap partition when you have 8GB of RAM?*  
**A:** With Gentoo, you will need it, period. It's just a matter of time before you fill up your RAM in virtual machines, /var/tmp/portage in tmpfs or you add some overzealous options to your compiler that won't allow the data to fit in RAM. In that case, wasting 10GB per-disk most of the year comes handy, as your server won't crash, it will experience a hell of a slowdown, but will keep running without allowing the infamous OOM killer to kick in and trash your vital application or DB, totally killing the user experience.

### Step 1: Clearing the drives and partitioning
For extra safety, you might want to zero out the first few megabytes of your drive. This will kill any previous MBR partition record and allow fdisk to present you a blank setup.

    root@localhost ~ # dd if=/dev/zero of=/dev/sda bs=10M count=1
    root@localhost ~ # dd if=/dev/zero of=/dev/sdb bs=10M count=1

Now go ahead and partition your first drive (sda in this case) using fdisk. Don't use cfdisk. Although it may sound tempting, it doesn't align partitions on a divisible-by-8 sector boundary (yet, as far as I know), which means you may incour the write penalty for 4k drives.

Dos and don'ts:

 * do: sort the partitions in the order you want (you may want: boot, swap, root)
 * don't
   * use the linux MD partition type when creating partitions, use the linux default one
   * use the swap partition type for the swap partition, leave the linux default one
   * partition the second disk, I'll come to it in a minute

### Step 2: Copy your partition setup with sfdisk
Easy paragraph: we'll use sfdisk (part of util-linux) to copy the partition setup from sda to sdb, performing a 1:1 copy, avoiding possible copy/paste issues.

    root@localhost ~ # sfdisk -d /dev/sda > partitions
    root@localhost ~ # sfdisk /dev/sdb < partitions

### Step 3: create the RAID arrays
### Step 4: setup the partitions
### Step 5: going with genkernel


Cheers,
Fabio Scaccabarozzi
