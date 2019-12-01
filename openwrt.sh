opkg update
opkg install block-mount kmod-usb-storage kmod-usb2 kmod-fs-vfat kmod-fs-ext4 e2fsprogs e2freefrag tune2fs f2fs-tools fdisk mkf2fs mount-utils luci-i18n-base-zh-cn

mkdir -p /tmp/introot
mkdir -p /tmp/extroot
mount --bind / /tmp/introot
mount /dev/sda1 /tmp/extroot
tar -C /tmp/introot -cvf - . | tar -C /tmp/extroot -xf -
umount /tmp/introot
umount /tmp/extroot
