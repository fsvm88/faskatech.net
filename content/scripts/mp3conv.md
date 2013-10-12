---
title: mp3conv
subtitle: Sanitize mp3!
kind: script
layout: scripts
---
This illustrates a simple script I\'ve made to reconvert mp3 files\.

It does the following things\:

1. Reconvert mp3s
1. Apply gain to mp3s
1. Sanitize tags and migrate them to specified version

This was to allow easier compatibility with all of the programs/devices when reading mp3 music\. Specified formats can be tuned to needs, of course\.
It is available through rsync at rsync\://matrix\.faskatech\.net/mp3conv\. It took me a while to rework all of the odds of bash scripting when it comes to paths containing spaces, but finally I made it\. It is not perfectly working, as when re-executed multiple times creates spurious paths\. Please beware that on the last step **all** of the tags get automatically stripped\. That was to allow easier editing later, killing spurious entries and/or unwanted/unreadable tag fields\. I suggest tag\-editing through EasyTag \(very versatile, easy and fast\)\.
