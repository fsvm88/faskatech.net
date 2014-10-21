---
title: neo2-overlay
kind: overlay
layout: pages_with_sidebar
---

{::options parse_block_html="true" /}

<article>
## media-video/atipower
Ebuild for atipower. There has never been an ebuild for such program. It goes back to the days when I used the fglrx driver. This little well written program has the ability to show (and select) even power/clock statuses that are hidden from the aticonfig utility. This is often the case of desktop cards that have different 2D/3D clocks. My X1900XT fan would spin down to achieve lower noise, reducing power consuption, of course. Perfect in combination with a login startup script that runs at logon to your favourite Desktop Manager. I will always keep it in my main overlay.
</article>

<article>
## sys-kernel/reiser4-sources
Ebuild for a reiser4-enabled kernel. Based off gentoo-sources (with all the related patches) plus the latest patch that applies to the kernel for reiser4-support. This is used during liveCD build process, I update it whenever I have to rebuild the CDs.
</article>
