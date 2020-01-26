# MySQL学习

## 1 MySQL安装并登录

~~~shell
# apt -y install mysql-server
# service mysql start
# mysql -uroot -p //回车即可登入
~~~

## 2 MySQL设置密码

~~~shell
# mysqladmin -uroot newpassword (new passwd);	
~~~

### 2.1 MySQL修改密码

~~~shell
# sqladmin -uroot -pxxx password new-password;	//way	1
# set password for root@localhost = password('new password')	//way	2
# 当忘记密码时,可以通过修改 /etc/mysql/mysql.conf.d/mysqld.cnf 给它加上一句 skip-grant-tables,然后重启MySQL即可设置密码
~~~

注意⚠:当我们设置完密码以后,并且重启MySQL以后,还不用输入密码就可以直接进入MySQL的话,有两种原因

①	有空用户

~~~shell
# select * from mysql.user where user='';	//查看是否存在空用户,如果有就执行下面两条命令,没有就看下面一种原因
# use mysql;
# delete from user where user = '';
~~~

②	验证方式为 **auth_socket**

~~~shell
# use mysql;
# update user set authentication_string=password("new-password"),plugin='mysql_native_password' where user='root'
~~~

改完配置记得再改回去,并重启服务​💫  

## 3 数据库基本命令

创建数据库

~~~sql
create database db_name;
~~~

显示数据库

~~~sql
show databases;
~~~

删除数据库

~~~sql
drop database db_name;
~~~

使用数据库

~~~sql
use StudentInfo;
~~~

创建数据表

~~~sql
create table tb_name (字段名 varchar(10),字段名 char(6));
~~~

显示数据表

~~~sql
show tables;
~~~

显示表结构

~~~sql
desc tb_name;
~~~

删除表

~~~sql
drop tb_name;
~~~



eg:

~~~sql
carete table userInfo(
	sno char(19) primary key,
	sname char(20) unique,
	ssex char(2),
	sage smallint,
);
~~~

## 4 插入数据

🐖 col = 字段名 = column

~~~sql
insert into tb_name(value1,value2s,etc);
~~~

~~~sql
insert into tb_name(col1,col2,etc) values(val1,vla2,etc);
~~~



## 5数据库备份

### 1、备份命令

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --database 数据库名 > 文件名.sql

例如： 
~~~mysql
mysqldump -h 192.168.1.100 -p 3306 -uroot -ppassword --database cmdb > /data/backup/cmdb.sql
~~~



### 2、备份压缩

导出的数据有可能比较大，不好备份到远程，这时候就需要进行压缩

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --database 数据库名 | gzip > 文件名.sql.gz

例如：

~~~mysql
 mysqldump -h192.168.1.100 -p 3306 -uroot -ppassword --database cmdb | gzip > /data/backup/cmdb.sql.gz
~~~



### 3、备份同个库多个表

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --database 数据库名 表1 表2 .... > 文件名.sql

例如 

~~~mysql
mysqldump -h192.168.1.100 -p3306 -uroot -ppassword cmdb t1 t2 > /data/backup/cmdb_t1_t2.sql
~~~



### 4、同时备份多个库

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --databases 数据库名1 数据库名2 数据库名3 > 文件名.sql

例如：

~~~mysql
mysqldump -h192.168.1.100 -uroot -ppassword --databases cmdb bbs blog > /data/backup/mutil_db.sql
~~~



### 5、备份实例上所有的数据库

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --all-databases > 文件名.sql

例如：

~~~mysql
mysqldump -h192.168.1.100 -p3306 -uroot -ppassword --all-databases > /data/backup/all_db.sql
~~~



### 6、备份数据出带删除数据库或者表的sql备份

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --add-drop-table --add-drop-database 数据库名 > 文件名.sql

例如：

~~~mysql
mysqldump -uroot -ppassword --add-drop-table --add-drop-database cmdb > /data/backup/all_db.sql
~~~



### 7、备份数据库结构，不备份数据

格式：mysqldump -h主机名 -P端口 -u用户名 -p密码 --no-data 数据库名1 数据库名2 数据库名3 > 文件名.sql

例如：

~~~mysql
mysqldump --no-data –databases db1 db2 cmdb > /data/backup/structure.sql
~~~







