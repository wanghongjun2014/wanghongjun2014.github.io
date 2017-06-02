---
layout: page
title: "关于：About"
---
一些使用的小程序(包括不限于php, shell, python, go, mysql)

#### 1 --- (php) 统计php脚本是否在后台运行
```
function scriptIsRunning($key_word) {
    $key_word || $key_word = __CLASS__;
    $shell = "ps -ef | grep -v 'grep' |grep -v 'sudo' | grep '{$key_word}'";
    $cmd_run = @popen($shell, 'r');
    $total = 0;
    while(!feof($cmd_run)) {
        $content = trim(fgets($cmd_run, 1024));
        if(empty($content)){
            continue;
        }
        if (strpos($content, $key_word) !== false){
            $total++;
        }
    }
    @pclose($cmd_run);
    return $total;
}
```

$keyword表示运行的脚本关键词

