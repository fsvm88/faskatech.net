---
title: 'How-to: RAID1 with MD on two identical disks'
kind: guide
layout: '/posts.*'
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


## Step 0: planning
You will need *mdadm* to go on with the following steps (emerge sys-fs/mdadm).  
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

## Step 1: Clearing the drives and partitioning
For extra safety, you might want to zero out the first few megabytes of your drive. This will kill any previous MBR partition record and allow fdisk to present you a blank setup.

    dd if=/dev/zero of=/dev/sda bs=10M count=1
    dd if=/dev/zero of=/dev/sdb bs=10M count=1

Now go ahead and partition your first drive (sda in this case) using fdisk. Don't use cfdisk. Although it may sound tempting, it doesn't align partitions on a divisible-by-8 sector boundary (yet, as far as I know), which means you may incour the write penalty for 4k drives.

    fdisk /dev/sda
      # sda1: 200MB
      # sda2; 900GB
      # sda3: 10GB

Dos and don'ts:

 * do: sort the partitions in the order you want (you may want: boot, swap, root)
 * don't
   * use the linux MD partition type when creating partitions, use the linux default one
   * use the swap partition type for the swap partition, leave the linux default one
   * partition the second disk, I'll come to it in a minute

## Step 2: Copy your partition setup with sfdisk
Easy paragraph: we'll use *sfdisk* (part of *util-linux*) to copy the partition setup from sda to sdb, performing a 1:1 copy, avoiding possible copy/paste issues.

    sfdisk -d /dev/sda > partitions
    sfdisk /dev/sdb < partitions

## Step 3: create the RAID arrays
In case you are recycling an existing setup and have left the partitions unchanged, be sure to zero the RAID array superblocks with

    mdadm --zero-superblock /dev/sda*X* /dev/sdb*X*

Create the RAID1 array using the following syntax

    mdadm --create /dev/<name of the RAID device> --level 1 --raid-devices=2 /dev/sda<part num> /dev/sdb<part num>

Following the schema explained above, we will then issue the following commands

    # For boot
    mdadm --create /dev/md1 --level 1 --raid-devices=2 /dev/sda1 /dev/sdb1
    # For root
    mdadm --create /dev/md2 --level 1 --raid-devices=2 /dev/sda2 /dev/sdb2
    # For swap
    mdadm --create /dev/md3 --level 1 --raid-devices=2 /dev/sda3 /dev/sdb3

**Note:**  the md device number is arbitrary, it may change upon reboot

You can verify that your RAID arrays are correctly resyncing after creation by issuing:

    cat /proc/mdstat

You should see something like this:

    Personalities : [raid1] [raid10] [raid6] [raid5] [raid4] [raid0] [linear] [multipath] 
    md1 : active raid1 sda1[2] sdb1[1]
          255808 blocks super 1.2 [2/2] [UU]
          [=============>.......]  check = 68.6% (176000/255808) finish=0.0min speed=44000K/sec

## Step 4: setup the partitions
We will format the partitions according to the above schema with the following commands:

    mkfs.ext4 -L boot /dev/md1
    mkfs.xfs -d agcount=8 -l size=256m -l lazy-count=1 -s size=4096 -L root /dev/md2
    mkswap -L swap /dev/md3

The XFS command is complete of some optimization parameters:

  * -d agcount=8: increase allocation parallelism and decrease height of the data structures of the filesystem
  * -l size=256m: increase journal to a reasonable size for modern hard-disks
  * -l lazy-count=1: delay updates of certain FS structures, increasing performance
  * -s size=4096: set physical sector size of the underlying device to 4Kb

The last option is only useful for 4k modern hard-disks. A 512-byte HDD won't benefit from it, but neither will see a performance drop, hence is enabled by default.

## Step 5: do the actual installation
In this paragraph we will perform the most basic installation tasks, which are not worth detailed explanations, given their ease:

  * mount the root partition

        mount /dev/md2 /mnt/gentoo

  * extract the installation on the root filesystem
  * mount proc, sys and dev filesystems

        mount -t proc none /mnt/gentoo/proc
        mount -o bind /dev /mnt/gentoo/dev
        mount -o bind /sys /mnt/gentoo/sys

  * chroot into the installation

        chroot /mnt/gentoo /bin/bash

  * perform the usual installation tasks (setup environment, portage tree etc)
  * install mdadm (*emerge sys-fs/mdadm*)

## Step 7: setup mdadm
This is a simple step to have mdadm always use the same names, which will be the assigned ones at the time of execution of this command:

    mdadm --detail --scan >> /etc/mdadm.conf

Given that nowadays one uses labels and UUIDs over device names, this can be skipped without harm.

## Step 8: compiling your kernel with genkernel
The setup of the kernel is covered in a lot of guides throughout the web, rather than rewrite again well-known and documented information, I can only recommend the [Gentoo wiki on software RAID](http://wiki.gentoo.org/wiki/Complete_Handbook/Software_RAID){:target='_blank'} and the [Gentoo genkernel wiki](http://wiki.gentoo.org/wiki/Genkernel){:target='_blank'}, which contain the necessary steps to compile the kernel, plus, of course, many steps which are common to this guide.

**Note:** Remember to pass --mdadm to the genkernel commandline, in order to be sure to include mdadm in the initramfs.

## Step 9: setting up the bootloader
The choice is for grub2, which is now stable in the portage tree.  
Before installng the bootloader modify the GRUB_DISABLE_LINUX_UUID to false, so that grub will use UUIDs rather than device names when passing the root= option to the kernel commandline.  
Also remember to put "domdadm" in the GRUB_CMDLINE_LINUX variable, so that md array detection starts after kernel boot.  

    nano -w /etc/default/grub
        GRUB_CMDLINE_LINUX="domdadm"
        GRUB_DISABLE_LINUX_UUID=false

If using *systemd* rather than *openRC*, add also the real_init string to GRUB_CMDLINE_LINUX:

    nano -w /etc/default/grub
        GRUB_CMDLINE_LINUX="real_init=/usr/lib/systemd/systemd domdadm"

Lets finally install the bootloader on **both** disks:

    grub2-install --no-floppy --recheck /dev/sda
    grub2-install --no-floppy --recheck /dev/sdb

This will allow to start the system in case one of the disks fails, without liveCDs, allowing also for hot-recovery. Beware of course, that booting a 1-disk RAID1 array will be the same as booting without the RAID1 layer. If you lose the second disk, you lose everything.

## Step 10: a little optimization
We can push our configuration a little further, using a feature disabled by default, that can grant enormous speedups in case of power failures.

    mdadm --grow --bitmap=internal /dev/mdX

With this command we are adding a write-intent bitmap to the array. Basically, it works as a log of the writes in the array, allowing to resync only a small portion of the array in case of power failures. This has negligible performance cost, when compared with its benefits.  
You can find more information about it on the [RAID kernel wiki](https://raid.wiki.kernel.org/index.php/Write-intent_bitmap){:target='_blank'}.

**Note:** of course, this doesn't prevent a full resync after a disk failure. It serves as huge performance boost *only* in the case of a power failure, when the writes on the two disks may have not been committed entirely at the same time.

After the addition, you can verify that the bitmap is correctly working by looking at the last line of the md in the /proc/mdstat file:

    cat /proc/mdstat
      Personalities : [raid1] [raid5] [raid4] [raid0] [linear] [multipath] 
      md1 : active raid1 sda1[2] sdb1[1]
            255808 blocks super 1.2 [2/2] [UU]
            bitmap: 0/1 pages [0KB], 65536KB chunk
