#!/bin/bash
set -e
echo "Downloading and flashing Fedora 22"
# Below the --progrss will emit percentage that can be used by the gui to show progress bar
# the bs=1M is critical since it writes much more efficnient to the micro SD
# Flash the full image
curl -L -k http://mirror.sjc02.svwh.net/fedora/development/26/Server/armhfp/images/Fedora-Server-armhfp-26-20170512.n.0-sda.raw.xz --progress | unxz | dd of=/dev/mmcblk0 bs=1M conv=fsync
if [ "x$RESIZE" == "xtrue" ]; then
	echo -e "d\n3\nn\np\n3\n\n\nw\n" | fdisk /dev/mmcblk0
	e2fsck -f /dev/mmcblk0p3 || true
	resize2fs /dev/mmcblk0p3 || true
fi
sync
