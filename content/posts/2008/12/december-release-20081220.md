---
title: 'December release - 20081220'
kind: article
layout: posts
created_at: 2008-12-23 22:02
subject: livecd
tags:
- truecrypt
- release
- december
---
Alright! December release is ready and published!

For a full feature list have a look at the current feature set, or the ChangeLog. It would be completely pointless to list them all here.

Interesting updates include: reintegration of madwifi drivers + tools and keymap selection fix.

About the latter: the first release included a buggy genkernel version, I had no choice except use that one. The 2nd and 3rd releases, instead, were bugged by a fault of mine. I took the templates from the 2007.1 release, and reworked them. I never cared about the livecd/rcadd variable though, since all the hardware detection stuff was done via bootloader (gentoo acpi=on......) or with manual commands on exotic setups. Shortly, in the installcd-stage2 spec file the keymaps and consolefont rc scripts were specified, overriding the user selection done earlier (dokeymaps boot variable, on by default). Obviously, since /etc/conf.d/keymaps defaults to "us" keymap, it seemed like a bug in the selection script, and not in the boot sequence itself. Luckily the full spec file recheck allowed me to spot this issue.

I will publish the spec files also, but I'll also begin to write a script for automatic spec generation.

Enjoy this Christmas present, and have fun ;)

Cheers,
Fabio Scaccabarozzi
