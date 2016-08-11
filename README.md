# RSAHandler

首先我们要会生成RSA密钥文件，现在一步步的来给大家展示一下，如何生成我们所需的公钥和私钥文件：
RSA密钥生成过程

1.生成私钥文件
$ openssl genrsa -out private.pem 1024
openssl:是一个自由的软件组织,专注做加密和解密的框架。
genrsa:指定了生成了算法使用RSA
-out:后面的参数表示生成的key的输入文件
1024:表示的是生成key的长度,单位字节(bits)

2.创建证书请求
$ openssl req -new -key private.pem -out rsacert.csr
可以拿着这个文件去数字证书颁发机构（即CA）申请一个数字证书。CA会给你一个新的文件cacert.pem,那才是你的数字证书。(要收费的)

3.生成证书并签名，有效期10年
$ openssl x509 -req -days 3650 -in rsacert.csr -signkey private.pem -out rsacert.crt
509是一种非常通用的证书格式。
将用上面生成的密钥privkey.pem和rsacert.csr证书请求文件生成一个数字证书rsacert.crt。这个就是公钥

4.转换格式 将 PEM 格式文件 转换成 DER 格式
$ openssl x509 -outform der -in rsacert.crt -out rsacert.der
在 iOS开发中,公钥是不能使用base64编码的,上面的命令是将公钥的base64编码字符串转换成二进制数据

5.导出 P12 文件
在iOS使用私钥不能直接使用，需要导出一个p12文件。下面命令就是将私钥文件导出为p12文件。

$ openssl pkcs12 -export -out p.p12 -inkey private.pem -in rsacert.crt