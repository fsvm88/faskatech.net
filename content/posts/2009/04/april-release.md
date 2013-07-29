---
title: "April release (formerly \"March release\")"
kind: article
created_at: 2009-04-07 22:01
subject: 'livecd'
tags: [ 'minimal', 'april' ]
---
Hi all, guys\!

Been working on the release in the weekend\. The snapshot it is built against is 2009\-04\-03 evening\. I\'m aware of no critical feature update since then\.
There are some improvements\: some visible, some other invisible\.

About the former\:

xfsprogs has been updated to version 3\.0\.0 \+ xfsdump has been included
btrfs support has been included as well \(with btrfs\-progs\)
ext4 support reaches maturity\: marked stable upstream, works flawlessly\. Compatibility mode has been disabled, since there should be no use for it \(no static hardcoded \"ext4dev\" entries in the liveCD libs\)
madwifi\-ng does not compile\: at first, it seemed like an ebuild issue\: updating the checks for CONFIG_MODULE instead of CONFIG_KMOD should have done the trick \(and it did\)\. In the end it showed problems compiling, which are due to internal kernel structures changes/renames\. Since I\'m no madwifi developer, instead of collecting patches here and there and ending up with a \"might work\" driver, I chose to \"suspend\" it\. Until no official update becomes available through gentoo or the sf\.net repository, expect no update\. When it becomes available, I may opt for a \"bugfix\" release instead of rebuilding everything from scratch\. Note that ath5k is getting better and better, if you find out your card doesn\'t work try the in\-kernel one before asking a revbump for madwifi\-ng \:\)
unfortunately, there\'s no truecrypt\-6\.1a ebuild available\. Tried bumping, compiling, but it complains about missing pkcs11\.h\. The included version is 6\.0a\. Might get updated on the next revision\.
About the latter\: since kernel includes squashfs now, the underlying filesystem has been migrated to 4\.x, built with squashfs\-tools\-4\.0_pre20090324\. This is because otherwise the CD would fail to boot with mount errors\. From the performance perspective you should expect almost no gains and benefits\. It\'s just an underground change\. Building with squashfs\-tools\-3\.3 and squashfs\-tools4\.0_pre showed almost 1\:1 size matching between the images\. Maybe there\'s some optimization when decompressing related to in\-kernel routines being used, I can\'t tell that\. Anyway, booting process doesn\'t seem to show any speed changes\. To me it looks like squashfs 3\.x code was merged and renamed to 4\.x, nothing more, nothing less\. Just wanted to tell =\)

Enjoy the new release and have fun\! ;\)

Cheers,
Fabio Scaccabarozzi
