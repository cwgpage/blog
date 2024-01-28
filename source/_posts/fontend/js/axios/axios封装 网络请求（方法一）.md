---
title: axios封装网络请求（方法一）
excerpt: 在项目中使用axios封装网络请求，实现请求拦截、响应拦截的处理函数，二次封装post请求和get请求
categories:
 - [前端, axios]
tags: 
 - 前端
 - 封装
 - axios
date: 2022-12-6 13:10:00
---

# 什么是axios?
>  Axios 是一个基于 promise 的 HTTP 库，可以用在浏览器和 node.js 中。
# 特性
> * 从浏览器中创建 XMLHttpRequests
> * 从 node.js 创建 http 请求
> * 支持 Promise API
> * 拦截请求和响应
> * 转换请求数据和响应数据
> * 取消请求
> * 自动转换 JSON 数据
> * 客户端支持防御 XSRF
# 封装
> 一般是会在单独的文件里封装axios的，一般取名为request.js（看个人习惯），index.js中的代码如下。
>  说明：我这边是创建了axios的实例来封装的，并且可以扩展headers。

```javascript
// request.js

import axios from "axios";

/**
 * 封装网络请求
 * @param {*} baseUrl 接口域名
 * @param {*} config 配置参数
 * @param {*} headers 请求头
 * @returns 
 */
export const request = (baseUrl, config, headers) => {
  const axios1 = axios.create({
    baseURL: baseUrl, 
    timeout: 5000,
    headers: {
      //"Content-Type": "application/x-www-form-urlencoded",
      ...headers,
    },
  });
  // 请求拦截
  axios1.interceptors.request.use(
    (config) => {
      //这里做的是请求前需要做的处理，一般携带token等之类的处理
      return config;
    },
    (err) => {
      if (err && err.request) {
        console.log("这里做请求错误处理");
      } else {
        console.log("err=>链接服务器失败");
      }
      // 返回一个错误
      return Promise.reject();
    }
  );
  // 响应拦截
  axios1.interceptors.response.use(
    (res) => {
    // 这里是处理响应成功的处理
    return res
    },
    (err) => {
      if (err && err.response) {
        console.log("这里做响应错误处理");
      }
      // 返回一个错误
      return Promise.reject();
    }
  );
  return axios1(config);
};
```
> 到这里request.js文件我们已经封装好了。现在我们可以在别的文件来使用它，可以给予他封装post和get请求。

> 在其他文件中使用，我这里是在api.js中使用的（api.js主要是用来方网络请求的文件）

```javascript
// api.js

// 我们先引入干刚刚封装好的request方法
import { request } from '../utils/request';

// 这是接口域名
let baseUrls = ''

/**
 * 封装get方法
 * @param {*} url 接口地址
 * @param {*} params 传递的参数
 * @param {*} baseUrl 接口域名
 * @param {*} header 请求头
 * @returns 
 */
export const get = (url, params = {}, baseUrl = baseUrls, header = {}) => {
  return request(baseUrl, { url, params, method: 'get' }, header)
}

/**
 * 封装get方法
 * @param {*} url 接口地址
 * @param {*} data 传递的参数
 * @param {*} baseUrl 接口域名
 * @param {*} header 请求头
 * @returns 
 */
export const post = (url, data = {}, baseUrl = baseUrls, header = {}) => {
  return request(baseUrl, { url, data, method: 'post' }, header)
}

//使用 （可以把网络请求的方法放在一起）
// 举例 登录接口
export const login = (data) => {
  return post('/login', data)
}
// 这样我们就可以在别的地方来使用这个方法了
```

>好了今天的axios封装就到这里了，希望对你有帮助。

