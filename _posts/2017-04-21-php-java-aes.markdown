---
layout: post
category: "code"
title:  "php和java中对aes加密方式的不同"
tags: [aes,php,java]
---
  

周末的时候写了一个联通代扣取话费需求的接口,由于文档中只给出了java aes加密的示例, 加密方式为PKCS5, 但是这种方
式php中是不支持的(我用java的入参调试了n久, 结果都是错的, 坑了很长时间, 翻阅很多文档终于找到了方案), php的解决方案如下:
    
```
 //加密函数
 function encrypt($plaintext, $key) {
     $plaintext = pkcs5_pad($plaintext, 16);
     return bin2hex(mcrypt_encrypt(MCRYPT_RIJNDAEL_128, hex2bin($key), $plaintext, MCRYPT_MODE_ECB));
 }
 
 //解密函数
 function decrypt($encrypted, $key) {
     $decrypted = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, hex2bin($key), hex2bin($encrypted), MCRYPT_MODE_ECB);
     $padSize = ord(substr($decrypted, -1));
     return substr($decrypted, 0, $padSize*-1);
 }
 
 //pad偏移函数
 function pkcs5_pad ($text, $blocksize)
 {
     $pad = $blocksize - (strlen($text) % $blocksize);
     return $text . str_repeat(chr($pad), $pad);
 }
```
    
参考文档: [http://stackoverflow.com/questions/17835726/aes-encryption-using-java-and-php](http://stackoverflow.com/questions/17835726/aes-encryption-using-java-and-php "aes")
    
    


