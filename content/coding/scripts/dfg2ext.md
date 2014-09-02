---
title: dfg2ext
subtitle: Secure online defragmentation for ext2/3 filesystems
kind: coding
layout: pages_with_sidebar
---
This is a custom project I've always run on my own. I was looking for a way to defrag ext3 filesystems without having to back-up/restore, to have online defragmentation. I found davl-tools, installed and after that had some serious bash scripting. This is the cumulative work of over 2 years. Since davl-tools works also for ext2 filesystems you can also defragment ext2 filesystems.

As of now, it's available [on github](https://github.com/fsvm88/dfg2ext){:target='_blank'} ("activedevel" directory contains latest version, "stable" the previous stable one).

Just run "sh dfg5004.sh" if you wish to have a fast help at hand. If you want to have more info, the scripts are **heavily** commented. You'll find description for each function, complete changelog, todo list in dfg5004.sh and its sub-files.

Shortly:

* the **core approach** is very simplicistic: generate a list of fragmented files, "cp file file.unfragmented && mv file.unfragmented file"; relies on the anti-fragmentation features of the filesystem (aka: "allocate contiguosly if I know the size"); this also allows to defragment opened/locked files (/lib/libc.so being my nightmare at first)
* heavily relies on **functions**: less code, less bugs, more portability and speed (source files have been splitted to allow for clearer understanding)
* some functions return **error codes**: if some critical function fails, script will stop without touching the affected area (=saving your data)
* though disabled by default, **md5-summing** is implemented (available via commandline switch): avoids relocating modified data, you won't lose your modified data
* I'm a **speed** fanatic myself, I wanted the job done as fast as it could be done: functions and loops have been scheduled to provide minimum runtime overhead (=minimum time spent in non-useful/onetime jobs)
* it **needs** davl-tools; I'm providing a new version through a custom ebuild, patched to generate only the strict minimum for the script to run (no block allocation status->no more "cat list \| grep -v ..."->huge speedups); I still need to rework the script to recognize the new version, though
* some files will **never** be completely defragmented: this is due to the filesystem's structure and security descriptors, for those files we can only try to minimize the fragments (implemented function)
* allows **user-set exclusions** (per-partition): >~75Mb files will never get to 1 fragment and will waste a lot of script's time when defragmenting, you can safely exclude them or the entire directory
