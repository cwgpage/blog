---
title: node版本管理工具nvm在windows系统使用方法
excerpt: 在windows系统下安装和使用nodejs版本管理器nvm，包括有下载、安装、以及常用命令的介绍
categories:
 - [后端, nodejs]
 - [教程, nodejs]
tags: 
 - 后端
 - nodejs
 - nvm
date: 2022-12-5 21:18:00
---

## node版本管理工具nvm在windows系统使用方法

## 安装

### 1. 下载

> 尽管 NVM 并不支持 windows，但是可以运行在 WSL（Windows Subsystem for Linux）中，WSL 是一个可以运行在 Windows10上的一个 Linux子系统，WSL 安装包的地址：https://github.com/coreybutler/nvm-windows/releases

<img src="https://cdn.nlark.com/yuque/0/2022/png/28469598/1669162809821-d3ffce95-3299-42f9-9b9b-0ec1f4cc83b3.png" referrerpolicy='no-referrer' />

### 2. 下载完毕以后解压缩，然后双击开始安装

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fefeac5993084f6ca4a00664773e0f1d~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp" referrerpolicy='no-referrer' />


### 3. 选择 `nvm` 的安装路径

<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2a5237fc320a4fa0be6b3ff67cbb21e0~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?" referrerpolicy='no-referrer' />

### 4. 选择 `nodejs `的路径

<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/79f651a8dcec4534b20e51180df334ef~tplv-k3u1fbpfcp-zoom-in-crop-mark:4536:0:0:0.awebp?" referrerpolicy='no-referrer' />

## 检查是否安装成功

在 `cmd` 中输入 `nvm -v` 查看版本号

```shell
nvm -v
```

## 常用命令

```shell
# 安装指定node版本(可省略小版本号)
nvm install v14.15.0

# 切换到指定node版本(可省略小版本号)
nvm use v14.15.0

# 切换到最新的node版本
nvm use node

# 给不同的版本号设置别名
nvm alias node_cms 14.15.0

# 使用该别名
nvm use node_cms

# 查看已安装node列表
nvm ls 或 nvm list

# 用于卸载某个node版本
nvm uninstall (version)

# 用于展示当前在windows系统运行的nvm版本
nvm version 或 nvm -v
```

