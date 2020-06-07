# Frp 内网穿透

自打搞一个软路由,我就玩的可带劲了,什么 **Linux , Docker , Java** 各种技术都被逼提升了很多. 闲话不多说,直接说重点了

## 1. 准备工作:

-   frp-server & frp-client 可以在 [GitHub](https://github.com/fatedier/frp/releases) 里下载
-   域名(需要备案)
-   有公网IPの服务器一台 

## 2. 配置server端

我是用的是 amd64架构的,如果和我一样的话可以按我的命令来

```shell
wget https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz
tar -zxvf frp_0.33.0_linux_amd64.tar.gz
mv frp_0.33.0_linux_amd64.tar.gz frp #为了接下来方便一点
cd frp
rm frpc* #删除不必要的配置,也可以不删
nano frps.ini
```

```ini
[common]
bind_port = 7000 
#对外提供服务的端口

dashboard_port = 7500
#访问控制板的端口

token = 123456
#token,相对于一个简单的验证

vhost_http_port = 80
#http服务在服务器的代理端口
```

可以根据自己的喜好设定这些配置

## 3. 配置client端

```shell
wget https://github.com/fatedier/frp/releases/download/v0.33.0/frp_0.33.0_linux_amd64.tar.gz
tar -zxvf frp_0.33.0_linux_amd64.tar.gz
mv frp_0.33.0_linux_amd64.tar.gz frp #为了接下来方便一点
cd frp
rm frps* #删除不必要的配置,也可以不删
nano frpc.ini
```

### 3.1 单网站配置(非必选)

```ini
[common]
server_addr = yourdomain.com
#你的域名/填写IP地址也可以 <记得把你的域名解析到服务器的IP地址上>

server_port = 7000
#需要和上面的server配置相同

token = 123456
#需要和上面的server配置相同

[http]
type = http
local_port = 80
custom_domains = yourdomain.com
```

### 3.2 多网站配置(非必选)

如果你有多个web项目的话,哪就建议你用二级域名

```ini
[common]
server_addr = yourdomain.com
server_port = 7000
token = 123456

[web1]
type = http
local_port = 80
custom_domains = a.yourdomain.com

[web2]
type = http
local_port = 8080
custom_domains = b.yourdomain.com

[web3]
type = http
local_port = 8088
custom_domains = c.yourdomain.com
```

### 3.3 ssh配置(非必选)

```ini
[ssh]
type = tcp
#ssh服务请使用tcp连接

local_ip = 127.0.0.1
local_port = 22
remote_port = 11484
#需要打开服务器端的该端口の防火墙
```

## 4. 浏览器验证

浏览器输入 ` http://yourdomain.com` 理论上就可以打开你在 client 上的web项目了

如果你遇到了 

**Chrome 浏览器打不开网页!**

**IE 浏览器也打不开网页**

别急! ! 换**FireFox**浏览器试一下  / |&&| \ 使用**Chrome**的无痕模式打开试一下