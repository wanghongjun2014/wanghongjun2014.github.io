---
layout: post
category: "code"
title:  "dyld: Library not loaded"
tags: [php]
---

今天莫名其妙的出现了如下错误
```
php -v
dyld: Library not loaded: /usr/local/opt/jpeg/lib/libjpeg.8.dylib
  Referenced from: /usr/local/bin/php
  Reason: image not found
[1]    24433 abort      php -v
```

解决办法是重新安装下libjpeg.8.dylib这个包
```
wget -c http://www.ijg.org/files/jpegsrc.v8d.tar.gz
tar xzf jpegsrc.v8d.tar.gz
cd jpeg-8d
./configure
make
cp ./.libs/libjpeg.8.dylib /usr/local/opt/jpeg/lib
```
ps: 如果编译之后找不到libjpeg.8.dylib这个文件, 可以用如下命令查找文件位置
```
find / -name libjpeg.8.dylib
```
