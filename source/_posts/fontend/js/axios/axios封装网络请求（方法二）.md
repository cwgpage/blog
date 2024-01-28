---
title: axios封装网络请求（方法二）
excerpt: 在项目中使用axios封装网络请求，实现请求拦截、响应拦截的处理函数，二次封装post请求和get请求
categories:
 - [前端, axios]
tags: 
 - 前端
 - 封装
 - axios
date: 2022-12-6 21:36:00
---

# axios介绍

## 什么是axios?

> Axios 是一个基于 promise 的 HTTP 库，可以用在浏览器和 node.js 中。

## 特性

> * 从浏览器中创建 XMLHttpRequests
> * 从 node.js 创建 http 请求
> * 支持 Promise API
> * 拦截请求和响应
> * 转换请求数据和响应数据
> * 取消请求
> * 自动转换 JSON 数据
> * 客户端支持防御 XSRF

# 安装实用

## 安装

```bash
npm install axios
```

## 封装

### 创建实例

> 一般是会在单独的文件里封装axios的，一般取名为request.js（看个人习惯），request.js中的代码如下。

```javascript
// request.js

import axios from 'axios'

// 创建一个axios的实例，用request接受
const request = axios.create({
  // baseUrl,这里填写请求的url
  baseURL: https://127.0.0.1/, 
  // 超时时间
  timeout: 8000,
  // 请求头的设置，后续还可以更改
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
    'Access-Control-Allow-Origin-Type': '*'
  },
  withCredentials: false
})
```

### 请求拦截

> 在请求拦截中一般放token等所有接口都需要的公共参数

```javascript
// request.js

request.interceptors.request.use(
  (config) => {
    console.log('config', config)
    // let token = localStorage.token || null
    // config.headers.common['Authorization'] = token
    return config
  },
  (err) => {
    return Promise.reject(err)
  }
)
```

### 响应拦截

> 在相应拦截中我们可以处理数据等相关操作

```javasc
// request.js

request.interceptors.response.use(
  (response) => {
    console.log('response', response)
    let {status, message, data} = response.data
    if (status !== 200) {
      return Promise.reject(response.data || '发生错误')
    }
    return Promise.resolve(data)
  },
  (error) => {
    return Promise.reject(error)
  }
)
```

## 进一步封装post和get

### 封装get请求

```javascript
// request.js

export function get(url, params) {
  return new Promise((resolve) => {
    request.get(url, { params }).then(res => {
      resolve([null, res])
    }).catch(err => {
      resolve([err, undefined])
    })
  })
}
```

### 封装post请求

```javascript
// request.js

export function post(url, data) {
  return new Promise(resolve => {
    request.post(url, data).then(res => {
      resolve([null, res])
    }).catch(err => {
      resolve([err, undefined])
    })
  })
}
```

# 使用封装好的post和get请求

> 在api.js文件中引入并用封装好的post和get对api统一处理

```javascript
// api.js

import {post, get} from '@/utils/request'

// 登录
export function login(data) {
  return post('api/login', data)
}

// 获取用户信息
export function register(data) {
  return get('api/userinfo', data)
}
```

> 再点击登录按钮的时候我们调用登录的接口方法

```js
function toLogin() {
  let [err, res] = await login(loginForm)
  if (err) {
    console.log('这里是后端响应非200的情况', err)
    return
  }
  // 这里处理成功的响应（是200的情况）
  console.log(res)
}
```

