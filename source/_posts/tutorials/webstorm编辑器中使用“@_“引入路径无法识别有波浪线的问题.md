---
title: webStorm 编辑器中引路的路径“@/“ 无法识别 有波浪线
excerpt: 解决一个烦人的问题，在webstorm中引用路径有下划线的问题，提示语法有问题（对于一下有强迫症的开发者真的是很烦）。
categories:
 - [教程, webStorm]
 - [前端, vue]
tags: 
 - 开发工具
 - webStorm
 - 教程
date: 2022-12-6 13:30:00
---

# webstorm 编辑器中引路的路径“@/“ 无法识别 有波浪线
> 在webstorm中引用路径有下划线的问题，提示语法有问题。
>
# 解决办法
在项目的根路径下，也就是跟package.json同级的目录下创建**jsconfig.json**这个文件，在文中写入
```json

{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": {
      "@/*": [
        "src/*"
      ]
    }
  },
  "exclude": [
    "node_modules",
    "dist"
  ]
}
```
> 通过这个方法我们就可以解决webstorm使用@引入的路径有警告，报黄的问题，同时也可以点击引入的文件跳过去了。



