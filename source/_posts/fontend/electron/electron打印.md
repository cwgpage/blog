---
title: electron 项目中主进程中需要知道的信息怎么在控制台中显示
excerpt: electron 项目中主进程中需要知道的信息怎么在控制台中显示
categories:
 - [前端, electron]
tags: 
 - 前端
 - electron
 - log
---


## 进程中的打印怎么在控制台中显示

### 方法一
```js
// 进程中的文件，通过win进行发送
win.webContents.send('log', '打印');
```

```js
// 渲染层中进行接收到log方法
ipcRenderer.on('log', (e, info) => {
  console.log(info) // 打印
})
```