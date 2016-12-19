---
title: 'Website refactor'
kind: article
created_at: 2014-09-02 20:19
subject: website
desc: 'Website refactoring part 2'
tags:
 - changes
 - updates
 - website
 - nanoc
---
Hi all!  

After struggling for a (very long) while with [nanoc](http://nanoc.ws/){:target='_blank'}, I was able to make many small improvements to the site structure.  
<!--MORE-->
"Scripts" section has disappeared in favor of a more generic "Coding" one, divided by language.  
Lots of cleanups went into JavaScript and CSS (which is now written in SASS).  
Site layouting was changed to slim for better readability and maintainability (and less HTML-did-I-close-the-tag? headaches).  
I pushed dfg2ext and mp3conv to [github](https://github.com/fsvm88){:target='_blank'}, rather than having them hang around on rsync. They lie there as an example of bash scripting rather than still-working scripts (seriously, *don't* use them).  

I am applying for becoming a Gentoo developer, and I am slowly testing packages and fixing [clang bugs](https://bugs.gentoo.org/408963){:target='_blank'}.

I will try to follow up this round of updates with some serious nanoc examples, as I find that the documentation online is somewhat scarce.  
You will find them under the newly added "Guides" section, along with a new RAID1 guide for MD (*mdadm*).

In the meanwhile I also migrated my server to a much more powerful one, basically, everything doubled in the specs. I am partecipating in many [BOINC projects](http://boincstats.com/it/stats/-1/user/detail/208278/projectList){:target='_blank'} now, compared to the 4-5 previous ones.


Cheers,  
Fabio Scaccabarozzi  
