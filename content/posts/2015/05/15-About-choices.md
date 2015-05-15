---
title: 'Reasons why I killed systemd'
subtitle: 'AKA: systemd vs openrc'
kind: article
layout: posts
created_at: 2015-05-15 14:00
subject: website
tags:
  - changes
  - systemd
  - openrc
  - init
  - linux
  - system
  - systemd vs openrc
---
This won't be another rant-post about the neverending systemd vs openrc war.
I am writing to mostly state the reasons why I killed systemd in favor of openRC, the Gentoo-sponsored init alternative.

<!--MORE-->

## Having binary logs is useless

If you have ever had a server fail, especially during boot, then you already know where this is headed.  
If you don't, in short: you want the logs to be readable with "less" or "cat".  
The reason is that often you're booting from a liveCD, and you usually hope that the last few log lines have been written to your log file.
Even though filesystems have become much more robust in handling power cutoffs, binary files are much easier to break than simple text files. Probably the developers have done their best to ensure that this doesn't happen, but still... it's not working for me.  
How can you grep a binary file? The fact that you have to go through journalctl to get your lines of log sounds crazy to me. How can you grep multiple logs when you don't know where to find the line? Oh yeah, everything's all in one place...

## Solving the dependency problems?

This one is a little trickier than the previous one.  
Basically, what happens with systemd is that you don't need to mess with init services and dependencies anymore. He does the job in your place. You just enable the services you need and he does the rest.  
Is it really a good idea on a server machine?  
I can't count the times I found started services that I had explicitly disabled. These were "dependencies" of services which got pulled in because they were specified in their systemd service file. The point is, the services I was interested in could actually work without these *optional* deps, but systemd treated those ones has "hard" deps.  
I do remember one time where in order to disable a service, I actually had to remove its service file from the */usr/lib64/systemd/system* directory, because "disable" simply didn't work. That leads us to the next point.

## File layout is a mess

By trying to solve the problem, in my opinion systemd made it worse.
I don't know for other distros, but for Gentoo you have this big repository of service files which is */usr/lib64/systemd/system*, where all the packages install their service files. Previously that place was */etc/init.d*, and I actually liked that because it gave the admin the chance to *update* the init file and *look* at the changes.  
Now everything happens without anybody noticing.

## Init scripts should be short

Systemd tries really hard to slim down service files, along the lines of "init scripts should not be long and hard to read". Agreed.  
What happens now is that the previous 100-lines-long init script is shifted to a bash script living somewhere in the package directory, with the same old init content: directory setup, permission changes and so forth.
  
## Security and linux philosophy
On a side note, from the security point of view, I really don't like the idea of slamming 1MB of binary code which does *everything* into a process on which the whole system relies so heavily. That makes it for a very *huge* attack surface, as opposed to the 40KB sysvinit (which does **one** thing).  

## Epilogue

This is just a small list of reasons why I went back to openRC, and never looked back. I experimented with systemd when it was still in its infancy, and I saw it grow full of features for almost two years. I eventually came to a point where it was a much bigger issue troubleshooting systemd's problems than openRC ones, so I stepped back.
  
  
Cheers,  
Fabio Scaccabarozzi
