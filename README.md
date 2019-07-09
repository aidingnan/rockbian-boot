# rockbian-boot
bootloader image for booting rockbian.

This project create a bootloader image for booting rockbian. Only emmc is supported.

The image inludes:

1. MBR and partition table
2. rockchip-specific spl (idbloader)
3. u-boot
4. arm trusted firmware

All parts are combined into a single image file.

The assumption is the first partition is a btrfs file system, conforming to the layout and boot protocol required by Rockbian.
