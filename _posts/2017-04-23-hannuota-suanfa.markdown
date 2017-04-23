---
layout: post
category: "code"
title:  "汉诺塔算法"
tags: [汉诺塔]
---

下午研究下汉诺塔算法, 挺有意思的, 大体示意图如下:
![hannuota](/assets/hannuota.png "汉诺塔")

说明:A.B.C分别表示三根柱子, 1，2，3分别表示三个圆盘, 并且数字越大表示圆盘越大, 现在我们需要将A上的全部圆盘移动到C上
1. 只有一个圆盘1的情况, 直接从**A->C**
2. 有2个圆盘1 2, 则 A->B  **A->C** B->C
3. 有3个圆盘1 2 3的情况下, 总共需要7步。 A->C A->B C->B **A->C** B->A B->C A->C

分析过程, 不管有几个盘子, 最重要的就是**A->C**(步骤中加粗)这一步, 也就是把数字最大的盘子移动到C柱子上, 以3个盘子为例, 在A->C步骤的上面表示把1号和2号盘子
从起点A移动到终点B, 下面表示把1号盘子和2号盘子从起点B移动到终点C, 所以可以用一种递归的思想表示这个过程
```
假如函数原型是move(n, A, B, C)
#上面的部分: n-1个圆盘从A->B
move(n-1, A, C, B)
#中间部分, 号码最大的盘子从A->C
move(1, A, B, C)
#下面部分: n-1个圆盘从B->C
move(n-1, B, A, C)
```

算法代码为
```
#!/usr/local/bin/python3
# _*_ coding: utf-8 _*_

def move(n, a, b, c):
    if n == 1:
        print(a, '->', c)
    else:
        move(n-1, a, c, b)
        move(1, a, b, c)
        move(n-1, b, a, c)

count = input("请输入要移动到圆盘个数: ")
move(int(count), 'A', 'B', 'C')
```
效果为:

![result](/assets/hannuota-result.png "结果")
