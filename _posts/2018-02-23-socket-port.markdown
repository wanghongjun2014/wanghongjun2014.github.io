---
layout: post
category: "code"
title:  "socket端口复用"
tags: [php]
---

### socket编程中的端口复用问题
一般来讲，在我们写一个server的时候，会用到SO_REUSEADDR，因为，当server正常或者异常重启的时候，
可能server的一些子进程或者client端的一些进程还在工作，也或者一些连接还处于time_wait状态，而且time_wait状态的时间一般比较长，
如果没有SO_REUSEADDR，则会因为端口被占用而bind失败，无法启动server，实例如下：
```
<?php
$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);

if (!is_resource($socket)) {
    echo 'Unable to create socket: '. socket_strerror(socket_last_error()) . PHP_EOL;
}

if (!socket_set_option($socket, SOL_SOCKET, SO_REUSEADDR, 1)) {
    echo 'Unable to set option on socket: '. socket_strerror(socket_last_error()) . PHP_EOL;
}

if (!socket_bind($socket, '127.0.0.1', 1223)) {
    echo 'Unable to bind socket: '. socket_strerror(socket_last_error()) . PHP_EOL;
}

$rval = socket_get_option($socket, SOL_SOCKET, SO_REUSEADDR);

if ($rval === false) {
    echo 'Unable to get socket option: '. socket_strerror(socket_last_error()) . PHP_EOL;
} else if ($rval !== 0) {
    echo 'SO_REUSEADDR is set on socket !' . PHP_EOL;
}

```
注意：
端口被占用后，不是listen是否能够成功，主要是bind能否成功，bind会报端口被占用的错误。
