---
layout: post
category: "code"
title:  "php的4种回调函数风格"
tags: [php]
---

### 匿名函数

```
$server->on('Request', function ($req, $resp) {
    echo "hello world";
});
```

### 类静态方法
```
class A
{
    static function test($req, $resp)
    {
        echo "hello world";
    }
}
$server->on('Request', 'A::Test');
$server->on('Request', array('A', 'Test'));
```
### 函数
```
function my_onRequest($req, $resp)
{
    echo "hello world";
}
$server->on('Request', 'my_onRequest');
```

### 对象方法
class A
{
    function test($req, $resp)
    {
        echo "hello world";
    }
}

$object = new A();
$server->on('Request', array($object, 'test'));
