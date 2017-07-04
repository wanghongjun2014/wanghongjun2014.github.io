---
layout: post
category: "code"
title:  "mysql正常运行偶尔会自动停止"
tags: [mysql]
---

一个外包项目的mysql数据库服务今晚上突然自己停止了, 回来查看mysqld进程确实没了, 然后查看mysql的error_log， 发现错误如下

![result](/assets/mysql-error.png "结果")

这个是因为mysql升级软件包之后, 一些表的结构发生变化导致的, 可以运行如下命令解决:
```
mysql_upgrade -u root -p
```

结果如下:

![result](/assets/mysql-error-ok.png "结果")


