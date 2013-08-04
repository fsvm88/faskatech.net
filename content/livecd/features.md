---
kind: livecd
layout: livecd
---
### Features
LiveCD releases are based off Gentoo Minimal LiveCDs, they feature\:

* dev\-lang/perl
* app\-crypt/truecrypt
* full update of system packages 
* reiser4\-sources \(with custom power patches\) && reiser4progs 
* latest unstable gcc
* latest unstable glibc
* 2008\.0 pure profile
* wider hardware support \(mostly PATA/SATA controllers and wireless cards\)\: if the kernel being used for the new release supports new hardware it will be included in the next release as well \(ath5k etc\.\.\.\)
* various extra packages

Some have already asked for X/graphics inclusion, my answer has always been \"no\" for the following reasons\:
* minimal liveCDs weigh ~100Mb, full liveCDs ~700Mb or more \(less pain for users, faster availability\)
* troubleshooting the base profile with basic settings it\'s a matter of hours, whereas troubleshooting \>700 packages it\'s a matter of weeks \(I don\'t have such time\)
* I don\'t have enough CPU power available to make a big release available to the public in my few spare weeks \(2~3 weeks every 3~4 months\)

### Known & Solved issues
Since nothing is perfect, here\'s a list of the known issues with the all the current releases\:

* doesn\'t have splashscreen/progress bar at boot, no framebuffer decorations
* using provided stage3 to install forces you to unmask latest gcc, glibc and linux-headers in /etc/portage/package\.keywords right after install to prevent downgrades
* if you want to migrate to reiser4 on root partition, you have to edit /etc/init\.d/checkroot to avoid fsck segfaults \(file available through server\); otherwise, you can update e2fsprogs and unmask latest reiser4\-progs, that provides compatibility with e2fsprogs \(can be \"normally\" fixed using baselayout\-2 \+ reiser4progs\-1\.0\.6\-r2\)
Unable\-to\-include drivers\:
* rt2500 wireless drivers \(newer ones should be available in\-kernel\)
* slmodem \(not even latest unstable does compile\)
* FIXED\: acx, acx\-firmware \(latest acx 0\.3\.38 doesn\'t compile\)
* FIXED\: madwifi\-ng, madwifi\-ng\-tools \(latest unstable doesn\'t compile\)

And here instead, a list of the past issues that have been solved\:

* doesn\'t allow keymap selection at boot \(can be done later with loadkeys\)
