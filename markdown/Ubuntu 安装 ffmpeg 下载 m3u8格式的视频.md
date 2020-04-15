# Ubuntu 安装 **ffmpeg** 下载 m3u8格式的视频

最近想下载一个某音视频,但是我能看不能下载,这不是扯吗?于是不能忍的我就打算盘盘这个视频

## 1 . 准备环境:Ubuntu 18.04 , FFmpeg

本着万物皆可 **Linux** の初心,我就不想用Windows了.

首先安装 **ffmpeg**

~~~shell
sudo apt -y install ffmpeg
~~~

## 2 . 抓包短视频的m3u8地址

iOS端,我是使用的 **Thor** 这个app,比较好用,应用商店搜索就有

然后得到真实的地址:

~~~http
http://XXX.com/xxx/xxx.m3u8
~~~

## 3 . 使用 **ffmpeg** 进行下载

~~~shell
ffmpeg -i http://XXX.com/xxx/xxx.m3u8 -c copy xxx.mp4
~~~

然后就需要慢慢等待下载完成就可以了,真的是特别特别的简单