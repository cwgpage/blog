---
title: 异步请求 同步写法async和await的用法
excerpt: 如何优雅的解决异步回调地狱，如何优雅的解决Promise异步回调问题
index_img:
categories: 
 - [前端, javascript]
tags: 
 - 前端
 - javascript
 - async/await
date: 2022-12-6 13:30:00
---
# async/await 是什么
> async/await 是ES7提出来主要解决Promise异步回调的问题。
> async/await可以让我们更优雅的实现异步编程的写法。


### 旧的写法
```javascript
/*
  getHomeData是我们用来请求数据的方法。
*/
getData() {
  getHomeData().then(res => {
    // 这个res,就是我们接口返回的数据
    console.log('res,' res)
    if (res.status === 200) {
       // res.data就是我们需要的数据
       console.log('data,' res.data)
    }
  })
},
// 再简单点 用解构赋值的方式可以更快的获取
getData() {
   getHomeData().then({data, status} => {
  	 if (status !== 200) return
     // 解构出来的data,就是我们需要的数据
     console.log('data,' data)
   })
},
```

### async/await 写法
> 我们可以在请求的函数前面加上asyne关键字，然后在请求的时候使用await关键字，这样我们在进行异步请求的时候就可以不要使用.then，直接使用res来进行接收，res就是接口返回的数据。
```javascript
/*
  getHomeData是我们用来请求数据的方法。
*/
async getData() {
   let res = await getHomeData();
   // 这个res,就是我们接口返回的数据
   console.log('res,' res)
   if (res.status === 200) {
      // res.data就是我们需要的数据
      console.log('data,' res.data)
   }
},
```

简单写法
> 我们还可以使用解构赋值的方式更简单的获取数据
```javascript
async getData() {
   let {data, status} = await getHomeData();
   if (status!==200) return
   // 这里的data就是我们要获取的数据
   console.log('data,' data)
},
```

> 这些就是async/await的简单介绍了。
