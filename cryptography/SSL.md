
# 单向认证

- 客户端认证服务器
- 服务器不认证客户端
- 服务端的证书使用自签名证书openssl生成

## 1. 服务器端

### 分析流程

1. 创建http服务器
2. 启动时加载自己的证书，启动时使用tls

```bash
openssl req -x509 -nodes -newkey rsa:2048 -keyout server.key -out server.crt -days 165 -subj "/C=CN/ST=Beijing/L=Beijing/O=Global Security/OU=IT Department/CN=*"
```

## 2 客户端

1. 注册给服务器颁发证书的ca
    - 读取ca证书
    - 把ca的证书添加到ca池中
2. 配置tls
3. 创建http client
4. client 发送请求
5. 打印返回值


# 双向认证

- 客户端认证服务器
- 服务器不认证客户端
- 服务端的证书使用自签名证书openssl生成server.crt
- 客户端的证书使用自签名证书openssl生成client.crt

## 1. 服务端

1. 注册client ca证书
    - 读取ca证书
    - 创建ca池
    - 把ca的证书添加到ca池中

2. 配置tls => cfg

3. 创建http server,使用cfg

4. 启动httpserver,启动时加载使用自己的server.crt，配置tls


## 2. 客户端


1. 注册给服务器颁发证书的ca
    - 读取ca证书
    - 把ca的证书添加到ca池中
1.1 加载客户端的证书和密钥
2. 配置tls，增加clientCert
3. 创建http client
4. client 发送请求
5. 打印返回值
