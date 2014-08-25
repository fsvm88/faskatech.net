---
title: mp3conv
subtitle: Sanitize mp3!
kind: script
layout: pages_with_sidebar
---
This illustrates a simple script I've made to reconvert mp3 files.

It does the following things:

1. Reconvert mp3s
1. Apply gain to mp3s
1. Sanitize tags and migrate them to specified version

This was to allow easier compatibility with all of the programs/devices when reading mp3 music (especially my now-defunct first and rusty mp3 player). Specified formats can be tuned to needs, of course.
It is available [on github](https://github.com/fsvm88/mp3conv){:target='_blank'}.
It took me a while to rework all of the odds of bash scripting when it comes to paths containing spaces, but finally I made it. It is not perfectly working, as when re-executed multiple times creates spurious paths. Please beware that on the last step **all** of the tags get automatically stripped. That was to allow easier editing later, killing spurious entries and/or unwanted/unreadable tag fields.
I suggest tag-editing through EasyTag (very versatile, easy and fast).
