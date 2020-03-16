# Bay Trail主板安装Linux的坑

最近搞了一个 **N2920** 的低功耗小主机,本来打算搞软路由,但是家里网速不行,就打算先刷个 **Linux** 玩玩,于是我就被这个问题烦了将近半个月!

一开始我打算安装一个 **CentOS 7** 玩玩,当我下载完系统刻录完开始安装的时候发现 **CentOS 7** 的 installer 异常的卡顿,而且耗时也非常的多,差不多需要将近半个小时才可以到图形界面的安装(我这个小主机是有固态的,这个速度肯定有很大的问题),而且好不容易到了图形界面的安装环节,还经常卡死!刚开始 我还以为可能是这个ISO镜像有问题,又换了一个 **CentOS 8** 的镜像. 

刻录--安装--等待--卡死

Again

开机--安装--等待--卡死

🙂🙂🙂我真的是......一点办法都没有

这结果属实有点意外呀,怎么 **CentOS 8** 也是这个鸟样?

我不甘,又换了一个 **Ubuntu 18** 

刻录--安装--等待--卡死

卧槽,这是什么问题换系统 都不行,应该就不是软件的问题了吧,我就从主板开始动刀,会不会是因为主板的 **BIOS** 太老了,本来打算去更新一下 **BIOS** 结果,这是一个不知名的小板,不知道从哪里搞到 **BIOS** 文件,就放弃了!

然后去百度 *为什么电脑安装Linux卡顿*

众所周知,百度相当垃圾,大部分都是答非所问,要不然就是 ~~CSDN,简书~~ 的水贴,都没有用 **:(**

然后我又找隔壁 二狗子 意念扶梯子,用Google搜一下

然后我就在国外某个被大陆404的的技术论坛上找到了一点线索😏😏😏

贴子网址: [askubuntu](https://askubuntu.com/questions/803640/system-freezes-completely-with-intel-bay-trail)

反正他们大概说的是 **Bay Trail** 主板上安装Linux出现的各种异常,刚刚好我的主板也是,出现的问题也和他们的很相似

在这里截取一些解决方法:

~~~shell
#Your processor is affected by the c-state bug

#This causes total freezes when the CPU tries to enter an unsupported sleep state. It's a problem for many Bay Trail devices especially with newer (4.*) kernels.

#Affected processors AFAIK:

#Atom Z3735F (Asus X205TA, Acer Aspire Switch 10, Lenovo MIIX 3 1030)
#Atom Z3735G
#Celeron J1900 (Asus ET2325IUK, shuttle XS35V4)
#Celeron N2940 (Acer Aspire ES1-711, Chromebook)
#Celeron N2840 (Acer Aspire ES1-311)
#Celeron N2930 (Jetway JBC311U93, Zotac Nano CI320)
#Pentium N3520
#Pentium N3530 (Acer V3-111P)
#Pentium N3540 (Dell Inspiron 15 3000, Lenovo G50, ASUS X550MJ)
#(please (suggest an) edit to add your own device if affected)

#Complete list of Bay Trail processors may be found here

#There is a simple workaround for this until it gets properly fixed upstream.

#You just need to pass a kernel boot parameter and the random freezing stops completely. The parameter may increase battery consumption slightly, but it will give you a usable system.

#You do this by editing the configuration file for GRUB:

#Boot Ubuntu and open a terminal by pressing Ctrl+Alt+T then type

sudo nano /etc/default/grub
#Find the line that starts GRUB_CMDLINE_LINUX_DEFAULT=

#This needs to be changed to include intel_idle.max_cstate=1

#So after your edit it reads something like

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash intel_idle.max_cstate=1"
#quiet and splash are default parameters for Ubuntu Desktop - no need to change them, or any other pre-existing parameters

#Now save the file by pressing ctrl+o then enter and exit by pressing ctrl+x

#Now run

sudo update-grub
#Then reboot.

#What to do if you don't have enough time to do this before the system hangs

#No problem. As explained on the help page I linked to earlier, you can add the parameter to GRUB before booting. Note that this only passes the parameter for the current boot, so you still have to edit /etc/default/grub once you have booted to make the change permanent.

#You need to get to the GRUB menu. If you are dual booting this will appear anyway, if not you have to press and hold (or tap) shift after pressing the power button to turn on.

#When you get to this screen select Advanced Options for Ubuntu. You can move the cursor to a different kernel, or leave it in place to edit options for the default. Instead of pressing enter, press e and you will go into edit mode, looking vaguely like this.

#Move the cursor down to where it says quiet splash, put a space after splash and carefully type intel_idle.max_cstate=1 making sure there is a space after it as well.
~~~

反正大概意思就是这种主板有残疾,在引导的时候会导致一些问题,需要加上这些参数就可以了

至此,这个烦了我将近半个月的问题没有了,就在引导的时候加了几个参数,鼠标正常了,键盘也可以用了,也不会卡顿了