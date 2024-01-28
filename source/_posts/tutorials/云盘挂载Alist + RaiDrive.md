---
title: Alist + RaiDrive 实现将网盘挂载到本地
excerpt: 本教程是实用Alist + RaiDrive 实现网盘挂载，Alist可以添加很多种类的网盘，如阿里云盘、百度云盘、天翼云盘、谷歌云盘、123云盘、115云盘、一刻相机...
categories:
 - [教程, 云盘挂载]
 - [教程, RaiDrive]
tags: 
 - Alist
 - RaiDrive
 - 教程
 - 云盘挂载
date: 2022-12-6 13:30:00
---

# 云盘挂载

本教程是实用Alist + RaiDrive 实现网盘挂载，Alist可以添加很多种类的网盘，如阿里云盘、百度云盘、天翼云盘、谷歌云盘、123云盘、115云盘、一刻相机...

## 安装AList 



[AList ]([Home | AList文档 (nn.ci)](https://alist.nn.ci/zh/))的安装方式有很多，这里我以 Windows 的手动安装为例

1. 打开[这个链接](https://www.jackxjz.com/?golink=aHR0cHM6Ly9naXRodWIuY29tL2FsaXN0LW9yZy9hbGlzdC9yZWxlYXNlcw==)，找到自己相应的系统版本并下载

![在这里插入图片描述](https://img-blog.csdnimg.cn/fb697b58e53549248dc38a3d47ef9dcb.png)
2. 解压文件，并将 `alist.exe` 文件置于一个单独的文件夹
3. 点击上方地址栏，输入`cmd`回车或者在当前文件夹中打开`PowerShell`
4. 输入`alist server`回车，若看到`start server @ 0.0.0.0:端口号`则代表启动成功
![在这里插入图片描述](https://img-blog.csdnimg.cn/93064975b5f148a0959ba348a0c41b83.png)

5. 接下来我们用浏览器打开下方三种链接的其中一个

   - [localhost:5244](localhost:5244)
   - [127.0.0.1:5244](127.0.0.1:5244)
   - [0.0.0.0:5244](0.0.0.0:5244)

   > 端口号以实际运行结果为主

  ![在这里插入图片描述](https://img-blog.csdnimg.cn/813752ddb52f430e8e91ab612d5ac868.png)


6. 点击下方登录，默认用户名为**admin**，默认密码在终端界面，登录后页面右上角会有提示

![在这里插入图片描述](https://img-blog.csdnimg.cn/e6429c7d3c8f4306b6b8b53a7823dbcd.png)


![在这里插入图片描述](https://img-blog.csdnimg.cn/2f74fecef737449990b5ba24d3dd4454.png)


## AList后台配置

### 修改密码



1. 点击下方管理，建议先修改用户名和密码

![在这里插入图片描述](https://img-blog.csdnimg.cn/2b74b075152f400c895f6a62967180f5.png)


![在这里插入图片描述](https://img-blog.csdnimg.cn/1423d2a618424da6af6a443727779e4d.png)


### 添加存储



1. 切换到存储选项卡，点击添加，不同网盘的配置方式不同，可看[官方文档](https://www.jackxjz.com/?golink=aHR0cHM6Ly9hbGlzdC5ubi5jaS96aC9ndWlkZS9kcml2ZXJzL2NvbW1vbi5odG1s)

![在这里插入图片描述](https://img-blog.csdnimg.cn/b4e66798b0fe4e09879c464c17fdda50.png)


#### 阿里云盘



1. 打开 [AList 文档](https://www.jackxjz.com/?golink=aHR0cHM6Ly9hbGlzdC5ubi5jaS96aC9ndWlkZS9kcml2ZXJzL2FsaXl1bmRyaXZlLmh0bWw=)，点击获取 Token
2. 将 Token 填入刷新令牌中
3. 根文件夹ID默认为`root`，若想添加单独的文件夹，只需用阿里云盘打开文件夹，网址最后的就是根文件夹ID

#### 123云盘



123云盘的配置就很简单了，只需要网盘的用户名和密码

![在这里插入图片描述](https://img-blog.csdnimg.cn/15f35589b2df44bbb7f0e9af77c73ab9.png)


## 安装 RaiDrive

在 Windows 电脑上，我们可以使用 [RaiDrive]([RaiDrive](https://www.raidrive.com.cn/)) 将 AList 挂载到本地

1. 打开 [RaiDrive](https://www.raidrive.com.cn/) 官网，下载最新版 RaiDrive 并安装
2. 安装完成后打开 RaiDrive，点击添加

![\[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-QgK7PJY4-1670040562036)(E:\mediaFile\RaiDrive.png)\]](https://img-blog.csdnimg.cn/4fdae5f4474a459ea0bcead527b86c23.png)


3. 选择 NAS 里的 Webdav，选择一个盘符，取一个名字；取消勾选**地址**，填上地址（`127.0.0.1`）和端口号，路径填 `dav`，再填上用户名和密码，点击连接

![在这里插入图片描述](https://img-blog.csdnimg.cn/778a99a415094797a5193276883e2efa.png)


4. 就能在此电脑这里直接管理 AList 上的文件上的文件

![\[外链图片转存失败,源站可能有防盗链机制,建议将图片保存下来直接上传(img-kAF4F6Nl-1670040562037)(E:\mediaFile\Alist.png)\]](https://img-blog.csdnimg.cn/d9984d7fea4b495b8e1439c034f3b246.png)


> 注意：因为`RaiDrive`无法识别容量所以才显示`7.99EB`

好了，这时候就挂在成功啦！
