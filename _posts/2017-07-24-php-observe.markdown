---
layout: post
category: "code"
title:  "php观察者模式"
tags: [php]
---

最近公司项目开发过程中有场景用到了观察者模式, 记录一下
一些面向对象的编程方式，提供了一种构建对象间复杂网络互连的能力。当对象们连接在一起时，
它们就可以相互提供服务和信息。这个模式对于大型系统项目来说应该是挺挺有用的，通俗的讲，
这种模式允许某个类去观察另一个类。当一个类被改变时，观察类就会收到通知并且做出相应的动作

在平时的项目中还是挺有用的，比如一个用户下了一笔订单，下单成功后，就需要去发送短信/邮件的通知，库存的修改，账户余额的修改等等很多操作。

在之后的PHP5.0起，内置的SPL标准库中就提供了这种设计模式接口供大家使用，接下了就通过实例来学习一下。

SPL 提供了 SplSubject 和 SplObserver 接口。
SplSubject 接口提供了attach()、detach()、notify() 三个方法。而 SplObserver 接口则提供了 update()方法。
```
<?php
/**
 * 这一模式的概念是SplSubject类维护了一个特定状态，当这个状态发生变化时，它就会调用notify()方法。
 * 调用notify()方法时，所有之前使用attach()方法注册的SplObserver实例的update方法都会被调用。
 *
 */
interface SplSubject{
    public function attach(SplObserver $observer);//注册观察者
    public function detach(SplObserver $observer);//释放观察者
    public function notify();//通知所有注册的观察者
}
interface SplObserver{
    public function update(SplSubject $subject);//观察者进行更新状态
}
```
使用所提供的接口，来实现观察者模式
```
<?php
/**
 *具体目标
 */
class Salary implements SplSubject {
    private $observers, $money;
    public function __construct() {
        $this->observers = array();
    }

    public function attach(SplObserver $observer) { //注册观察者
        $this->observers[] = $observer;
    }

    public function detach(SplObserver $observer) { //释放观察者
        if($idx = array_search($observer,$this->observers,true)) {
            unset($this->observers[$idx]);
        }
    }

    public function notify() { //通知所有观察者
        foreach($this->observers as $observer) {
            $observer->update($this);
        }
    }

    public function payoff($money) { //发工资方法
        $this->money = $money;
        $this->notify(); //通知观察者
    }
}
/**
 * 具体观察者
 */
class Programmer1 implements SplObserver {
    public function update(SplSubject $subject) {
        echo 'Programmer1 发工资了！<br/>';
    }
}

class Programmer2 implements SplObserver {
    public function update(SplSubject $subject) {
        echo 'Programmer2 也发工资了！<br/>';
    }
}

$subject = new Salary();
$observer1 = new Programmer1();
$observer2 = new Programmer2();
//注册观察者
$subject->attach($observer1);
$subject->attach($observer2);
//发工资操作，发起通知
$subject->payoff('20K');

```
通过Observer模式，把一对多对象之间的通知依赖关系的变得更为松散，大大地提高了程序的可维护性和可扩展性，也很好的符合了开放-封闭原则。东西是不错，如何能够更好的去使用它，仍需要多加实践、联系



