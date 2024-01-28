---
title: file和base64格式转换
excerpt: base64转file|file转base64|base64转blob-blob转file
categories:
 - [前端, javascript]
tags: 
 - 前端
 - javascript
 - 格式转换
---

## base64转file

```js
/**
 * base64转file
 * @param { base64 } base64
 * @param { string } filename 转换后的文件名
 * @return {{}} file
 */
export const base64ToFile = (base64, filename )=> {
  let arr = base64.split(',');
  let mime = arr[0].match(/:(.*?);/)[1];
  let suffix = mime.split('/')[1] ;// 图片后缀
  let bstr = atob(arr[1]);
  let n = bstr.length;
  let u8arr = new Uint8Array(n);
  while (n--) {
    u8arr[n] = bstr.charCodeAt(n)
  }
  return new File([u8arr], `${filename}.${suffix}`, { type: mime })
};
```



## file转base64

```js
/**
 * file转base64
 * @param { * } file 图片文件
 * @return {base64}
 */
export const fileToBase64 = file => {
  let reader = new FileReader();
  reader.readAsDataURL(file);
  reader.onload = function (e) {
    return e.target.result
  };
};
```



## base64转blob, blob转file

```js
/**
 * base64转blob
 * @param { base64 } base64
 * @return {blob}
 */
export const base64ToBlob = base64 => {
  let arr = base64.split(','),
    mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]),
    n = bstr.length,
    u8arr = new Uint8Array(n);
  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }
  return new Blob([u8arr], { type: mime });
};

/**
 * blob转file
 * @param { blob } blob
 * @param { string } fileName
 * @return {blob}
 */
export const blobToFile = (blob, fileName) => {
  blob.lastModifiedDate = new Date();
  blob.name = fileName;
  return blob;
};
```

