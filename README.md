# tencent_rtc_plugin

腾讯云实时音视频插件

## 功能清单
[x]房间相关接口函数  
[x]视频相关接口函数  
[x]音频相关接口函数  
[x]摄像头相关函数  
[ ]直播相关接口函数
[ ]美颜滤镜相关接口  
[ ]自定义采集和渲染  
[ ]自定义消息发送  
[ ]背景混音相关接口  
[ ]音效相关接口  
[ ]网络测试  
[ ]混流转码并发布到 CDN  
[ ]Log相关接口  
[ ]播放背景音乐的回调接口  
[ ]视图边距  
[x]回调事件  
[ ]枚举类型同步(大改动)  
[ ]数据对象同步(大改动)  

## Getting Started

该插件基于腾讯音视频通话进行集成。    
引用腾讯官方文档原文：``在 defaultConfig 中，指定 App 使用的 CPU 架构(目前 TRTC SDK 支持 armeabi ， armeabi-v7a 和 arm64-v8a) 。``  
如果出现闪退问题，请检查是否是系统架构导致

## 集成

### Flutter
```
  tencent_rtc_plugin:
    git:
      url: https://github.com/JiangJuHong/FlutterTencentRtcPlugin.git
      ref: master
```
暂不支持通过版本号引入

### Android
无需额外配置，已内部打入混淆规则

### IOS
暂不支持

## 使用
大部分方法直接基于腾讯云原始API，根据 TencentRtcPlugin 对象即可使用；部分视频相关内容，TencentRtcVideoView 需要配合 TencentRtcVideoViewControlle调用方法;  
例如进入房间只需要调用``TencentRtcPlugin.enterRoom()``即可，腾讯API文档地址:[linke https://cloud.tencent.com/document/product/647/32264](https://cloud.tencent.com/document/product/647/32264)  
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentRtcPlugin/1.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentRtcPlugin/2.png" height="300em" style="max-width:100%;display: inline-block;"/>
