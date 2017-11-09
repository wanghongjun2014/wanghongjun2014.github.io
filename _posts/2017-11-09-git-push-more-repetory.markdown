---
layout: post
category: "git"
title:  "git同时推送到多个版本仓库"
tags: [php]
---

最近开发了个项目代码是放在公司的代码仓库里的，然后也想放在自己的github仓库里，下面配置可以实现：

1 编辑你本地的代码 .git/ 目录下的 config 文件,添加如下配置即可, 前提是开通代码库权限:  
```
[remote "all"]
    url = ssh://git@git.intra.weibo.com:2222/hongjun6/cron_monitor.git
    url = git@github.com:wanghongjun2014/cron_monitor.git
```  
其中每个url代表一个仓库, ssh 和 http 方式都可以  
2 然后执行 git push all 命令即可



