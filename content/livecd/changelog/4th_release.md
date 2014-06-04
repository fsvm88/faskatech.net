---
title: 4th release
date: 2008-12-20
kind: changelog
---
* 2.6.27.10 kernel + reiser4
* gcc 4.3.2
* glibc-2.9_p20081201
* linux-headers-2.6.27-r2
* Added packages:
    * app-admin/hddtemp
    * app-admin/testdisk
    * net-analyzer/bmon
    * net-analyzer/packit
    * net-analzer/tcptrack
    * net-wireless/wavemon
    * sys-apps/pv
    * sys-apps/smartmontools
    * sys-process/iotop
* Added drivers:
    * madwifi-ng
    * madwifi-ng-tools
* Removed drivers:
    * ipw3945: latest version does not compile against 2.6.27, the driver has been deprecated in favor of iwlwifi driver mantained by the kernel team
* Other notes
    * keymap selection at boot has been fixed: it was my fault when writing the spec files, I did not realize the connection between the keymaps/consolefont init scripts and the impossibility to keep the selected keymap, that is done earlier at boot (even before rc scripts)
    * madwifi-ng has been reintegrated upon request
