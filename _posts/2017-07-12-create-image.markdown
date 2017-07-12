---
layout: post
category: "code"
title:  "图片上生成文字, 或者图片上生成图片"
tags: [php]
---

存在我很脑子里的很长时间的一个观念终于改变了, 以前总喜欢搞些看起来高大上的代码, 不爱写业务代码, 喜欢钻研新技术, 新的工具,
对老的技术嗤之以鼻, 对不喜欢的技术比如css, html等极度排斥, 现在觉的不管写什么, 其实都能锻炼你的某方面能力, 希望以后的自己
可以放平心态, 什么都可以做, 能写php, python, shell, 做的了dba, 写的了业务代码, 搞得了服务器, 成为一个小的全栈工程师,
最近做的生成图片的功能比较多, 主要功能代码记录一下:
```
<?php

// 字体28-21,  32-24
// 一行股票高度 141 , 两行股票高度 202
$stockNum = 5;

$mainTitleText = "- 6月21日值得关注潜力股 -";
$font = '/usr/local/var/PingFang.ttc';
$circle = '/usr/local/var/circle.png';
$mainTitlePadding = padding($mainTitleText, 22.5);

// 股票文本
$text = array(
    '西的我的', '网络', '发发福', 'dfd'
);

$padding = array();

$circles = array(
    array('/usr/local/var/circle.png'),
    array('/usr/local/var/circle.png', '/usr/local/var/circle.png'),
    array('/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png'),
    array('/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png' , '/usr/local/var/circle.png'),
    array('/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png'),
    array('/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png', '/usr/local/var/circle.png'),
);

$count = count($text);
$fontSize = 25;
$backgroundHeight = ($count > 3) ? 204 : 148;
$im = imagecreatetruecolor(750, $backgroundHeight);

// 定义各种颜色
$white = imagecolorallocate($im, 255, 255, 255);
$red = imagecolorallocate($im, 223, 84, 82);
$black = imagecolorallocate($im, 0, 0, 0);
$yellow = imagecolorallocate($im, 240, 140, 51);
$blue = imagecolorallocate($im, 106, 142, 208);

$colors = array(
    array($red),
    array($red, $yellow),
    array($red, $yellow, $blue),
    array($red, $yellow, $blue, $red),
    array($red, $yellow, $yellow, $blue, $red),
    array($blue, $red, $yellow, $yellow, $blue, $red),
);
// 创建底层画布
imagefilledrectangle($im, 0, 0, 750, $backgroundHeight, $white);


// 总共分为两排, 第一排的数量 ($count - 3) 个, 第二个 3个
if ($count - 3 > 0) {
    // 主标题
    imagettftext($im, 22.5, 0, (750 - $mainTitlePadding['width']) / 2, 52, $black, $font, $mainTitleText);

    // 获得字体的宽度和高度
    foreach ($text as $key => $value) {
        $padding[] = padding($value, $fontSize);
    }

    $circle = $circles[$count - 1];
    $color = $colors[$count - 1];

    $before3Stocks = array_slice($text, 0, $count - 3, true);
    $next3Stocks = array_slice($text, $count -3, 3, true);

    $multi30 = count($before3Stocks) - 1 > 0 ? count($before3Stocks) - 1 : 0;
    $j = 0;
    foreach ($before3Stocks as $before => $beforeStockName) {
        $oneCircle = file_get_contents($circle[$before]);
        $oneCircle = imagecreatefromstring($oneCircle);
        imagecopyresized($im, $oneCircle, (750 - 196 * count($before3Stocks) - 30*$multi30) / 2 + 30 * $j + 196 * $j, 79,0,0,196, 48,imagesx($oneCircle),imagesy($oneCircle));
        imagettftext($im, 26, 0, (750 - 196 * count($before3Stocks) - 30 * $multi30) / 2 + 196*$j + 30*$j + (196 - $padding[$before]['width']) / 2, 115, $color[$before], $font, $before3Stocks[$before]);
        $j = $j + 1;
    }

    $oneCircle = ''; // 重新初始化

    // 第二排
    $i = 0;
    foreach ($next3Stocks as $k => $stockName) {
        $oneCircle = file_get_contents($circle[$k]);
        $oneCircle = imagecreatefromstring($oneCircle);
        imagecopyresized($im, $oneCircle, (750 - 196 * 3 - 30 *2) / 2 + 30 * $i + 196 * $i, 136,0,0,196, 48,imagesx($oneCircle),imagesy($oneCircle));
        imagettftext($im, $fontSize, 0, (750 - 196 * 3 - 30*2) / 2 + 196 * $i + 30 * $i + (196 - $padding[$k]['width']) / 2, 76 + (48 - $padding[$k]['height']) / 2 + 30 + 60, $color[$k], $font, $stockName);
        $i = $i + 1;
    }

} else {
    // 主标题
    imagettftext($im, 22.5, 0, (750 - $mainTitlePadding['width']) / 2, 52, $black, $font, $mainTitleText);

    // 获得字体的宽度和高度
    foreach ($text as $key => $value) {
        $padding[] = padding($value, $fontSize);
    }

    $circle = $circles[$count - 1];
    $color = $colors[$count - 1];
    $multi30 = count($text) - 1 > 0 ? count($text) - 1 : 0;
    $j = 0;
    foreach ($text as $k2 => $stockName) {
        $oneCircle = file_get_contents($circle[$k2]);
        $oneCircle = imagecreatefromstring($oneCircle);
         imagecopyresized($im, $oneCircle, (750 - 196 * count($text) - 30*$multi30) / 2 + 30 * $j + 196 * $j, 79,0,0,196, 48,imagesx($oneCircle),imagesy($oneCircle));
         imagettftext($im, 26, 0, (750 - 196 * count($text) - 30 * $multi30) / 2 + 196*$j + 30*$j + (196 - $padding[$k2]['width']) / 2, 115, $color[$k2], $font, $stockName);
        $j = $j + 1;
    }
}


header("Content-type: image/png");
imagepng($im);
imagedestroy($im);


// 返回文案的高度和宽度
function padding($text, $size)
{
    $font = $font = '/usr/local/var/PingFang.ttc';
    $largeText  = imagettfbbox($size, 0, $font, $text);
    $width = $largeText[2] - $largeText[6]; // 文字宽度
    $height = $largeText[3] - $largeText[7];
    return array(
        'width' => $width,
        'height' => $height
    );
}
```
结果如下:

![result](/assets/create_image.png "结果")


