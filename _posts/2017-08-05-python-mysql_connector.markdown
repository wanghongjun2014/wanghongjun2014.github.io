---
layout: post
category: "code"
title:  "python安装mysql驱动"
tags: [php]
---

安装python的mysql驱动的时候遇到的问题， 可以通过下面两种方式来安装
1
```
pip install mysql-connector-python --allow-external mysql-connector-python (pip install mysql-connector)
```

2 从mysql官网下载下来安装
```
https://dev.mysql.com/downloads/connector/c/
```
但是不管哪种方式安装都碰到了一个error, 安装不成功, 错误信息类似于
```
Unable to find Protobuf include directory.
```
最开始怀疑是这个驱动包不支持python3, 后来用pyhton2试了一下还是不行(ps: 安装python3的驱动的时候讲pip命令替换为pip3即可),
后来发现是版本的问题, 具体支持到哪个版本请自行查阅, 安装的时候带上版本号就可以了
```
 pip3 install mysql-connector==2.1.4
```
目前版本是2.1.4, 再高的版本没有试过