---
title: 8th release
date: 2011-03-04
kind: changelog
---
* 2\.6\.37\.2 kernel \+ reiser4
* gcc\-4\.5\.2
* glibc 2\.13\-r1
* linux\-headers 2\.6\.36\.1
* Drivers\:
    * NTFS in\-kernel driver disabled, only ntfs3g support is now available
* Other notes\:
    * full ~arch build \(instead of selective unmasking\)
    * dev\-util/metro is used for building the stages \(instead of catalyst\)
    * final strip phase disabled \(except for /usr/portage and /usr/src\)\: fully working stage3 setup \+ additional packages \(about  \+100Mb per\-CD\)
    * versioning modified\: now the release gets versioned with the release date
