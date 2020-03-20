# Docker  中运行  OpenWrt

前几天解决了小主机 **Ubuntu** 系统的引导问题以后.便开始折腾 **OpenWrt** 了,在 **GitHub** 上找到了 **L大** 的 **[Lede]( https://github.com/coolsnowwolf/lede )** 源码,需要自己编译.

关于如何编译我也不说了,**L大** 在 Readme 里面说的清清楚楚的,没有难度,就是需要有耐心和良好的网络环境,编译过程会很慢(建议扶梯子,我没有用梯子,整整编译了两天才完成!🤣🤣🤣) 也可以用我编译好的 **[x86_64](https://github.com/jokefrelon/linux-series/releases)** 的固件(集成有**ssr,v2ray,adblock plus,samba,vsftpd**等常用插件)

对于编译出来的文件我来介紹一下:

|  **openwrt-x86-64-rootfs-squashfs.img**   |      OpenWrt for Docker の img       |
| :---------------------------------------: | :----------------------------------: |
| **openwrt-x86-64-combined-squashfs.vmdk** |  **虚拟机文件,丢进VMware里面使用**   |
| **openwrt-x86-64-combined-squashfs.img**  | **我们编译的固件,刻录到u盘上来安装** |

我一开始也不知道这些镜像应该选哪一个刻录,然后爬各种论坛终于被我发现了这几个文件的用法了

好!环境已经没有问题,安装包也有了,那就先在 **Docker** 里面试试看这个 **OpenWrt** 怎么样吧

## 1 导入OpenWrt的镜像

~~~shell
cd ~/lede/bin/targets/x86/64
mkdir -p ~/opt
mount -o loop openwrt-x86-64-rootfs-squashfs.img ~/opt
tar -cvzf ~/Openwrt.tar.gz ~/opt/* 
docker import ~/OpenWrt.tar.gz OpenWrt
~~~

## 2 Docker 创建网络

~~~shell
docker network create -d macvlan --subnet=192.168.100.0/24 --gateway=192.168.100.1 -o parent=enp2s0 fet
~~~

这个IP地址需要根据你的实际IP更改,网卡也一样,不能照抄

## 3 Docker 运行容器

~~~shell
docker run -d --name lede --network fet --privileged OpeenWrt /sbin/init
~~~

在这里我一开始参考 **[OpenWrt 官方文档]( https://openwrt.org/zh/docs/guide-user/virtualization/docker_openwrt_image )**,结果一直报错,我一开始以为是他给的例子🌰里面系统太老,我就换成19.10,依旧报错,然后在网上瞎转悠的时候看到了一篇来自 [**美丽应用**]( https://mlapp.cn/376.html ) 的文章,虽然,他是在 **树莓派** 当中安装 **OpenWrt** 但是过程大多一样 (感谢 **美丽应用** 📌)

到这时,我们可以

~~~shell
docker ps
[sudo] frelon 的密码：
CONTAINER ID	IMAGE		COMMAND		CREATED		STATUS		PORTS		NAMES
4fe146d86277	OpenWrt		"/sbin/init" 2 hours ago  Up 2 hours			  lede
~~~

看一下我们的容器是否在正常运行,如果还在运行,那就说明容器没有问题可以进行下一步了

## 4 进入 OpenWrt 容器内,进一步配置

~~~shell
docker exec -it lede /bin/ash
~~~

这里要注意的是 **/bin/ash** 而不是 **/bin/bash** 

### 4.1 配置网络

#### 4.1.1查看一下 **IP**

~~~shell
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
25: eth0@if2: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:c0:a8:64:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
~~~

稍等片刻

~~~shell
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
4: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 02:42:c0:a8:64:02 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.1/24 brd 192.168.1.255 scope global br-lan
       valid_lft forever preferred_lft forever
25: eth0@if2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-lan state UP group default                                                                  link/ether 02:42:c0:a8:64:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0

~~~

#### 4.1.2 简易修改防火墙规则

~~~shell
opkg update
opkg install nano
nano /etc/config/firewall
~~~

找到 **config zone** 重点是把 **option input/output/forward** の **REJRECT** 改为 **ACCEPT**

~~~
config zone
        option name 'wan'
        list network 'wan'
        list network 'wan6'
        option input 'ACCEPT'
        option output 'ACCEPT'
        option forward 'ACCEPT'
        option masq '1'
        option mtu_fix '1'
~~~

然后重启一下

~~~shell
/etc/init.d/firewall restart
~~~

正常情况会报一堆错,无视即可

#### 4.1.3 修改网口

~~~
nano /etc/config/network
~~~

我是把 **interface lan** 的 **eth0** 给了 **interface wan**

然后又添加了一个网络进该容器,并分配给 **interface lan** 充当 **eth1**

~~~properties
config interface 'lan'
        option type 'bridge'
        option ifname 'eth1'
        option proto 'static'
        option ipaddr '192.168.1.1'
        option netmask '255.255.255.0'
        option ip6assign '60'
        option gateway '192.168.100.105'

config interface 'wan'
        option ifname 'eth0'
        option proto 'dhcp'
~~~

看着修改就可以了

~~~shell
/etc/init.d/network restart
~~~

### 4.2 网页登录

查看容器分配的ip,在网页中打开,正常情况下是可以打开的,

输入默认密码:key:**password**  就可以看到 **OpenWrt** の 状态信息

### 4.3 再添加一个网口到OpenWrt容器

~~~shell
docker network connect bridge OpenWrt
docker exec -it OpenWrt /etc/init.d/network restart
~~~

由于前面已经把 **eth1** 写入到配置信息里面,我们现在只需要重启一下网络即可,至此 **OpenWrt** の基本配置已经完成

如果需要配置 **OpenWrt** 旁路网关,建议参考上文提到的 [美丽应用]( https://mlapp.cn/376.html )

**本文参考资料来源:**

1.   Lean · coolsnowwolf/lede - GitHub : https://github.com/coolsnowwolf/lede 
2.  OpenWrt 官方帮助文档 :  https://openwrt.org/zh/docs/guide-user/virtualization/docker_openwrt_image 
3.  美丽应用 :  https://mlapp.cn/376.html 

