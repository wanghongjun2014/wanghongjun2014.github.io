---
layout: post
category: "git"
title:  "redis jemalloc报错"
tags: [php]
---

centos6.5安装redis报错,报错信息为
```
zmalloc.h:50:31: 错误：jemalloc/jemalloc.h：没有那个文件或目录
zmalloc.h:55:2: 错误：#error "Newer version of jemalloc required"
```

后来查看资料是因为：
说关于分配器allocator， 如果有MALLOC  这个 环境变量， 会有用这个环境变量的 去建立Redis。
而且libc 并不是默认的 分配器， 默认的是 jemalloc, 因为 jemalloc 被证明 有更少的 fragmentation problems 比libc。
但是如果你又没有jemalloc 而只有 libc 当然 make 出错

解决办法, make的时候加参数
```
make MALLOC=libc
```




