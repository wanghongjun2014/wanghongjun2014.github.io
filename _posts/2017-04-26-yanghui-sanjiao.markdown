---
layout: post
category: "code"
title:  "杨辉三角"
tags: [汉诺塔]
---


```

算法代码为
```
#!/usr/local/bin/python3
# _*_ coding: utf-8 _*_

def triangle(max):
    q = [1]
    n = 0
    while n < max:
        print(q)
        for i in range(1, len(q)):
            q[i] = p[i-1] + p[i]

        q.append(1)
        n = n + 1
        p = q[:]



triangle(6)

```
效果为:

![result](/assets/yanghui-sanjiao.png "结果")
