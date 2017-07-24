---
layout: post
category: "code"
title:  "php7中$GLOBALS['HTTP_RAW_POST_DATA']获取不到值"
tags: [php]
---

今天微信开发的时候碰到了一个问题, 接收不到微信推送过来的消息, 后来查明是因为php7中$GLOBALS['HTTP_RAW_POST_DATA']被废弃了,
可以使用 file_get_contents( 'php://input' ) 来获取, 可以在代码中判断是否可以用 $GLOBALS['HTTP_RAW_POST_DATA'] 来获取值


