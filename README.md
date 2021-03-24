# Linux 脚本合集
这个仓库是我用来存放我平时写的一些小脚本
## 1. [netspeed.sh](netspeed.sh)
简介：netspeed.sh是一个轻量且快速的查看当前网卡实时网速的脚本(Ubuntu 18~20适用)
由于不支持参数，所以默认查看的是你物理网卡的当前网速
注：脚本依赖于ifconfig命令，Ubuntu现在默认没有安装该命令，需要手动安装一下

```
sudo apt install net-tools
```
如果脚本无法在您的设备的系统上运行您可以自行修改或者issue

## 2. [Openwrt](Openwrt.md)
openwrt相关的脚本，已过时，放弃维护。

## 3. [cputemp.sh](cputemp.sh)
此脚本适用于Ubuntu系列用一句话命令来查看当前CPU温度