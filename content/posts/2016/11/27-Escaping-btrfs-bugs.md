---
title: 'Escaping BTRFS bugs'
subtitle: 'Thinking outside the box and saving your data!'
kind: article
created_at: 2016-11-27 17:30
subject: filesystem
tags:
  - filesystem
  - btrfs
  - bugs
  - fix
  - trick
  - hack
  - enospc
  - free space
  - space
---
Hi all!

Today I'd like to share a small yet valuable trick I had to learn while dealing with problems in the btrfs filesystem.  
I switched to the filesystem about 8 months ago to better manage space allocation and shutdown times, as it should be quicker to recover upon errors. So far the filesystem performed admirably considering its reputation, but today I hit a nasty bug in the (behold) free space handling code.  
Fiddling with large datasets, I managed to fill the whole volume, allocating chunks on the whole RAID1 configuration I setup. After removing the data though, things didn't go as planned.
<!--MORE-->
I run rebalances from time to time to reclaim large contiguous free space regions, and this time it seemed appropriate, considering I filled the RAID with 2TB worth of data and reclaimed ~1.75TB after a few hours. Should be easy right?

    # btrfs balance start /storage_vol

A nice ENOSPC error greets me. I re-checked I had free space available, nothing weird here (sample stat):

    # btrfs fi usage /storage_vol
    Overall:
    Device size:            3.58TiB
    Device allocated:     944.06GiB
    Device unallocated:       0.00B
    Device missing:           0.00B
    Used:                 940.34GiB
    Free (estimated):       1.33TiB      (min: 1.33TiB)
    Data ratio:                2.00
    Metadata ratio:            2.00
    Global reserve:       512.00MiB      (used: 0.00B)
    
    Data,RAID1: Size:469.00GiB, Used:468.46GiB
    /dev/sda3             469.00GiB
    /dev/sdb3             469.00GiB
    
    Metadata,RAID1: Size:3.00GiB, Used:1.70GiB
    /dev/sda               33.00GiB
    /dev/sdb               33.00GiB
    
    System,RAID1: Size:32.00MiB, Used:76.00KiB
    /dev/sda3              32.00MiB
    /dev/sdb3              32.00MiB
    
    Unallocated:
    /dev/sda               31.33TiB
    /dev/sdb               31.33TiB

There's even global reserve available, so what is going on here?  
Apparently btrfs is unable to detect that there's plenty of free space for rebalancing, even though the space is available - I can write new files, I tried writing 100GB and everything works. Using the -dusage=99 parameter (with **any** value) didn't have any effects, I would still get the "not enough free space" errors.  
It seems as if the rebalance code is checking whether there is "Device unallocated" space, and if none is available it's not even checking that there's actually "Free (estimated)" space. At this point, I was thinking whether I would have ever been able to rebalance at all again, since I had no way of relocating the whole volume and recreating it from scratch.  
After one hour spent browsing bug reports, I begun wondering if there was a simple hack that would be able to force the data in being relocated. It was at that point that I thought of the possibility of *shrinking* the volume. Btrfs, unlike XFS and ZFS, allows shrinking volumes, and since such operation is a safe operation, it *should* trigger data rebalancing and moving in case data was present in a zone-to-free area.

    # btrfs fi show
    Label: 'storage'  uuid: 949887cf-6716-4c4d-ad19-64a87dd88005
    Total devices 2 FS bytes used 470.17GiB
    devid    1 size 1.79TiB used 472.03GiB path /dev/sdb3
    devid    2 size 1.79TiB used 472.03GiB path /dev/sda3

Btrfs allows resizing single devices indipendently, the RAID1 replication is enforced at chunk level. I supposed that in order to allow rebalance I would have needed to free space on *both* devices, otherwise it would have run on one of the two devices but not on the second, because of lack of free space. Easy enough, the chunks were filled mostly with metadata so it didn't take too long to run the resize:

    # btrfs fi resize 1:-3G
    Resize '/storage_vol/' of '1:-3G'
    # btrfs fi resize 2:-3G
    Resize '/storage_vol/' of '2:-3G'

I had now a smaller filesystem that would still have triggered the bug because there would be no unallocated space. So, there goes the magic:

    # btrfs fi resize 1:max
    Resize '/storage_vol/' of '1:max'
    # btrfs fi resize 2:max
    Resize '/storage_vol/' of '2:max'

Expanding the filesystem again we get:

    # btrfs fi usage /storage_vol
    Overall:    
    Device size:            3.58TiB
    Device allocated:     944.06GiB
    Device unallocated:     6.00GiB
    Device missing:           0.00B
    Used:                 940.34GiB
    Free (estimated):       1.33TiB      (min: 1.33TiB)
    Data ratio:                2.00
    Metadata ratio:            2.00
    Global reserve:       512.00MiB      (used: 0.00B)
  
    Data,RAID1: Size:469.00GiB, Used:468.46GiB
    /dev/sda3             469.00GiB
    /dev/sdb3             469.00GiB
  
    Metadata,RAID1: Size:3.00GiB, Used:1.70GiB
    /dev/sda               33.00GiB
    /dev/sdb               33.00GiB
  
    System,RAID1: Size:32.00MiB, Used:76.00KiB
    /dev/sda3              32.00MiB
    /dev/sdb3              32.00MiB
  
    Unallocated:
    /dev/sda               31.33TiB
    /dev/sdb               31.33TiB

Now the volume has 6GB unallocated! No more ENOSPC!

**Addendum**: Note that when I started writing this article, I was running kernel 4.6. I'm now on 4.8 and cannot be sure whether this can still be reproduced.



Cheers,  
Fabio
