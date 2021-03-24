## 1.1 OpenWrt 常用插件
~~~shell
#/bin/sh
opkg update
opkg install block-mount kmod-usb-storage kmod-usb2 kmod-fs-vfat kmod-fs-ext4 e2fsprogs e2freefrag tune2fs f2fs-tools fdisk mkf2fs mount-utils luci-i18n-base-zh-cn
~~~
## 1.2 OpenWrt 挂载U盘
~~~shell
#/bin/sh
mkdir -p /tmp/introot
mkdir -p /tmp/extroot
mount --bind / /tmp/introot
mount /dev/sda1 /tmp/extroot
tar -C /tmp/introot -cvf - . | tar -C /tmp/extroot -xf -
umount /tmp/introot
umount /tmp/extroot
~~~

## x86-64架构 **OpenWrt** rootfs.img文件 

**Usage:**
~~~
mkdir -p ~/opt
mount -o loop openwrt-x86-64-rootfs.img ~/opt
tar -cvzf ~/openwrt.tar.gz ~/opt/*
docker import ~/openwrt.tar.gz OpenWrt
docker run -d --net host --name openwrt-docker -p 8080:80 -p 11480:22 --privileged OpenWrt /sbin/init
#--net 根据自己的喜爱,自行更改...
#-p 我只是把两个常用的端口映射出来了,自行更改...
docker ps
#If there is nothing comes out after the cmd.Congratulation!!! U are failed
docker exec -it openwrt-docker /bin/ash
~~~
Now Starting to Enjoy ur OpenWrt for Docker!!!
Download openwrt-x86-64-rootfs-squashfs.img openwrt-x86-64-combined-squashfs.vmdk openwrt-x86-64-combined-squashfs.img
in **[release](https://github.com/jokefrelon/linux-series/releases/download/1.0/OpenWrt.zip)**