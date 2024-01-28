---
title: electron 更新项目安装 electron-updater 自动更新安装
excerpt: 介绍在electron中使用electron-updater库进行自动更新安装的功能，主要用在项目更新时，需要重新安装
categories:
 - [前端, electron]
tags: 
 - 前端
 - electron
 - electron-updater
---

## 准备

需要准备一个静态服务，放置新版本的软件包；也可以使用插件等，我这边演示使用的是服务器

## 安装插件

```shell
npm run electron-updater
```

## 编写更新代码

### 进程文件代码

在项目的进程文件中创建update.ts文件，写入下面代码，注意：一定是放在程序的主进程文件中。

```js
// src/main/update.ts

import { ipcMain } from "electron";
import { autoUpdater } from "electron-updater"

autoUpdater.autoDownload = false; // 是否自动更新

/*
  * 在开启更新监听事件之前设置
  * 一定要保证该地址下面包含latest.yml文件和需要更新的exe文件
  */
autoUpdater.setFeedURL({
  provider: 'generic',
  url: 'http:******', // 打包文件存放地址
});

export default (win: any) => {
  // 发送消息给渲染线程
  function sendStatusToWindow(status?: any, params?: any) {
    win.webContents.send(status, params);
  }

  // 正在检测
  autoUpdater.on('checking-for-update', () => {
    sendStatusToWindow('Checking for update...');
  })

  // 可以更新版本
  autoUpdater.on('update-available', (info: any) => {
    sendStatusToWindow('log', { title: '可以更新版本', info })
    sendStatusToWindow('autoUpdater-canUpdate', info)
  })

  // 更新错误
  autoUpdater.on('error', (err: any) => {
    sendStatusToWindow('log', { title: '更新错误', err })
    sendStatusToWindow('autoUpdater-error', err)
  })

  // 发起更新程序
  ipcMain.on('autoUpdater-toDownload', () => {
    sendStatusToWindow('log', '发起更新开始')
    autoUpdater.downloadUpdate()
        .then(r => sendStatusToWindow('log', { title: '发起更新成功', r }))
        .catch(err => sendStatusToWindow('log', { title: '发起更新失败', err }))
  })

  // 正在下载的下载进度
  autoUpdater.on('download-progress', (progressObj: any) => {
    sendStatusToWindow('log', { title: '正在下载的下载进度', progressObj })
    sendStatusToWindow('autoUpdater-progress', progressObj)
  })

  // 下载完成
  autoUpdater.on('update-downloaded', (r) => {
    sendStatusToWindow('log', { title: '下载完成', r })
    sendStatusToWindow('autoUpdater-downloaded')
  })

  // 退出程序并安装
  ipcMain.on('exit-app', () => {
    autoUpdater.quitAndInstall()
  })

  // 重新检查是否有新版本更新
  ipcMain.on('monitor-update-system', () => {
    autoUpdater.checkForUpdates()
  })

  // 检测是否有更新
  setTimeout(() => {
    autoUpdater.checkForUpdates();
  }, 5000);
}
```

### 渲染层文件代码

在渲染层，renderer文件夹中创建组件（我这边是随便写的样式，可以自己修改）

```vue
<template>
  <div class="jspatch">
    <div v-if="showUpdater" class="update-wrapper">
      <p> {{ `当前：【${downloadProcess.transferred}】 / 共【${downloadProcess.total}】` }}</p>
      <p>进度：{{ downloadProcess.percent }}</p>
      <p>正在下载({{ downloadProcess.speed }})......</p>
    </div>
    <div v-if="isShow">
      <button @click="saveUpdate">确认更新</button>
      <p>{{ text }}</p>
    </div>
  </div>
</template>

<script lang='ts'>
import { defineComponent, reactive, toRefs } from "vue";
import { ipcRenderer } from "electron"

export default defineComponent({
  name: "Jspatch",
  setup() {
    const data = reactive({
      showUpdater: false,
      downloadProcess: {
        percent: 10,
        speed: 0,
        transferred: '1kb',
        total: "2M"
      },
      isShow: false,
      text: ''
    });

    function saveUpdate() {
      ipcRenderer.send("autoUpdater-toDownload");
    }

    // 发现新版本 once
    ipcRenderer.on("autoUpdater-canUpdate", () => {
      /*
       * 这儿会监听，如果info.version比现在版本小；就会触发；反之，不会触发
       */
      data.text = '发现新版本'
      data.isShow = true
    });
    // 下载进度
    ipcRenderer.on("autoUpdater-progress", (event, process) => {
      if (process.transferred >= 1024 * 1024) {
        process.transferred =
          (process.transferred / 1024 / 1024).toFixed(2) + "M";
      } else {
        process.transferred = (process.transferred / 1024).toFixed(2) + "K";
      }
      if (process.total >= 1024 * 1024) {
        process.total = (process.total / 1024 / 1024).toFixed(2) + "M";
      } else {
        process.total = (process.total / 1024).toFixed(2) + "K";
      }
      if (process.bytesPerSecond >= 1024 * 1024) {
        process.speed =
          (process.bytesPerSecond / 1024 / 1024).toFixed(2) + "M/s";
      } else if (process.bytesPerSecond >= 1024) {
        process.speed = (process.bytesPerSecond / 1024).toFixed(2) + "K/s";
      } else {
        process.speed = process.bytesPerSecond + "B/s";
      }
      process.percent = process.percent.toFixed(2);
      data.downloadProcess = process;
      data.showUpdater = true;
    });
    // 下载更新失败
    ipcRenderer.once("autoUpdater-error", (err) => {
      console.log('⚽ => 更新失败', err)
      data.text = '更新失败！'
      data.showUpdater = false;
    });
    // 下载完成
    ipcRenderer.once("autoUpdater-downloaded", () => {
      data.showUpdater = false;
      data.text = '更新完成，是否关闭应用程序安装新版本?'
      ipcRenderer.send("exit-app");
    });
    return {
      ...toRefs(data),
      saveUpdate
    };
  },
});
</script>

<style scoped>

.update-wrapper {
  width: 200px;
  height: 200px;
  font-weight: 700;
  color: red;
  background: #fff;
}

</style>
```

创建完成在app.vue中引用、使用

> 注意：修改版本号一定是修改package.json中的版本号。

## 整体更新流程

> 检测到有新版本 ---> 手动触发下载 ---> 显示进度条 ---> 下载完成，手动选择安装


