## nginx反向代理

nginx 一直都是我们比较常用的工具,它不仅功能强悍,而且性能也非常好👌,一直深受开发者的喜爱

并且我们经常用 **nginx** 反代来做负载均衡,那么 **nginx** の反代原理我也就不说了,咱就说咋操作吧

我把我的网站的 **nginx** 配置给拷贝了下来

~~~nginx
server {
    listen    443  ssl;
    server_name   www.jokeme.top;

    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains;preload" always;    
    ssl_certificate /ssl/3355633_www.jokeme.top.pem;
    ssl_certificate_key /ssl/3355633_www.jokeme.top.key;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
        proxy_pass http://www.jokeme.top:8080;
}
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}

server{
  listen 80;
  server_name localhost;
  rewrite ^(.*) https://$host$1 permanent;
}
~~~

我的网站呢,是通过 **docker** 跑在8080端口的 **https** ,如果日常需要访问的话是不太方便の,还需要敲端口号

**nginx** 通过把8080端口的数据代理到443端口,来实现我们直接通过域名来访问,也就是 **location** 里面の **proxy_pass**实现了反向代理的功能

而且当用户通过80端口访问 **http** 的时候还会自动转到443 端口的 **https** 这个就是下面的那个 **server** **rewrite**实现的

还有一个就是大家反代的时候一定要确认你那个端口是允许访问的,要不然你的配置没有问题,但就是拒接连接,或者连接超时,昨天晚上我就出现了这种情况,配置没有问题,但是网站就是不能访问,然后倒腾了一圈,才想起来是我防火墙没有开放端口😫