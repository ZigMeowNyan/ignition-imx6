#!/bin/bash
set -e
echo "Downloading and flashing Fedora 25 Workstation"
# Below the --progrss will emit percentage that can be used by the gui to show progress bar
# the bs=1M is critical since it writes much more efficnient to the micro SD
# Flash the full image
curl -L -k http://mirror.sjc02.svwh.net/fedora/releases/25/Workstation/armhfp/images/Fedora-Workstation-armhfp-25-1.3-sda.raw.xz --progress | unxz | dd of=/dev/mmcblk0 bs=1M conv=fsync
if [ "x$RESIZE" == "xtrue" ]; then
	echo -e "d\n3\nn\np\n3\n\n\nw\n" | fdisk /dev/mmcblk0
	e2fsck -f /dev/mmcblk0p3 || true
	resize2fs /dev/mmcblk0p3 || true
fi
sync
