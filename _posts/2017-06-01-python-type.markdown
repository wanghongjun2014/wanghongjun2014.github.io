---
layout: post
category: "code"
title:  "python中用type来创建一个类"
tags: [python]
---


起因是和同事讨论Python中的枚举类型的作用与php中有什么不同,后来发现python2.7中本身不带枚举类的,需要自己写代码实现,
3中已经自带枚举类的包了, 用type函数实现,一般我们用type来判断对象的类型(我更倾向用isinstance来判断), 但是type比较
少用的作用是用来创建一个类

### 代码如下
```
def __init__(self, name):
    self.name = name


def print_name(self):
    print(self.name)


bases = (object,)

attrs = {
    '__init__' : __init__,
    'print_name' : print_name
}

Duck = type('Duck', bases, attrs)

d = Duck('cola')
d.print_name()

```
其中type函数包括三个参数, 第一个是类的名字, 第二个可以理解成继承的类,但要是元组格式, 第三个参数是个dict类型, 里面可以包含类的成员变量
,也可以包含类的成员函数----其实当你用class定义一个类的时候, python解释器在遇到class的时候只会浏览检测一下class的语法之类的东西, 然后接着会用
内置的type函数来创建类.



