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



