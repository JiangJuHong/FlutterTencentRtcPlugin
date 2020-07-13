# tencent_rtc_plugin
[![pub package](https://img.shields.io/pub/v/tencent_rtc_plugin.svg)](https://pub.dartlang.org/packages/tencent_rtc_plugin)

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
**注意：部分接口未在Flutter层次实现枚举，请注意int类参数，参考腾讯云文档结合使用**

## 集成
### Flutter
```
tencent_rtc_plugin: ^[最新版本号]
```

### Android
无需额外配置，已内部打入混淆规则

### IOS
配置权限信息，在Info.plist中增加
```
<key>io.flutter.embedded_views_preview</key>
<true/>
<key>NSMicrophoneUsageDescription</key>
<string>App需要您的同意,才能访问麦克风</string>
<key>NSCameraUsageDescription</key>
<string>App需要您的同意,才能访问摄像头</string>
```

## 功能清单
### 通用接口(TencentRtcPlugin)
|  接口   | 说明  | 参数  | Android | IOS |
|  ----  | ----  | ----  | ----  | ----  |
| showDebugView  | 启用Debug视图【注意：目前版本IOS暂不支持】 | {mode:'模式,0,1,2'} | √ | -
| setConsoleEnabled  | 启用日志打印 | {enabled:'是否启用'} | √ | √
| enterRoom  | 进入房间 | {appid:'应用appid',userId:'用户ID',userSig:'用户签名',roomId:'房间号',scene:'应用场景',role:'角色',privateMapKey:'房间签名'} | √ | √
| exitRoom  | 退出房间 | - | √ | √
| switchRole  | 切换角色 | {role:'角色'} | √ | √
| setDefaultStreamRecvMode  | 设置音视频数据接收模式（需要在进房前设置才能生效）。 | {autoRecvAudio:'自动接收音频数据',autoRecvVideo:'自动接收视频数据'} | √ | √
| muteRemoteAudio  | 静音 / 取消静音 | {userId:'用户ID',mute:'是否静音'} | √ | √
| muteAllRemoteAudio  | 静音 / 取消静音 所有用户 | {mute:'是否静音'} | √ | √
| setRemoteViewFillMode  | 设置远程显示填充模式 | {userId:'用户ID',mode:'模式'} | √ | √
| setLocalViewFillMode  | 设置本地显示填充模式 | {mode:'模式'} | √ | √
| startLocalAudio  | 开启本地音频采集 | - | √ | √
| stopLocalAudio  | 关闭本地音频采集 | - | √ | √
| stopAllRemoteView  | 停止显示所有远端视频画面。 | - | √ | √
| muteRemoteVideoStream  | 暂停接收指定的远端视频流。 | {userId:'用户ID',mute:'是否禁止'} | √ | √
| muteAllRemoteVideoStreams  | 停止接收所有远端视频流。 | {mute:'是否禁止'} | √ | √
| setVideoEncoderParam  | 设置视频编码相关。 | {param:'视频编码参数'} | √ | √
| setNetworkQosParam  | 设置网络流控相关参数。 | {preference:'弱网下是“保清晰”还是“保流畅”。',controlMode:'视频分辨率（云端控制 - 客户端控制）'} | √ | √
| setLocalViewRotation  | 设置本地图像的顺时针旋转角度。 | {rotation:'角度枚举值下标(参考腾讯云)'} | √ | √
| setRemoteViewRotation  | 设置远端图像的顺时针旋转角度。 | {userId:'用户ID',rotation:'角度枚举值下标(参考腾讯云)'} | √ | √
| setVideoEncoderRotation  | 设置视频编码输出的（也就是远端用户观看到的，以及服务器录制下来的）画面方向。 | {rotation:'腾讯云枚举'} | √ | √
| setLocalViewMirror  | 设置本地摄像头预览画面的镜像模式。 | {mirrorType:''腾讯云枚举} | √ | √
| setVideoEncoderMirror  | 设置编码器输出的画面镜像模式。 | {mirror:'编码器输出的画面镜像模式'} | √ | √
| setGSensorMode  | 设置重力感应的适应模式。 | {mode:'腾讯云枚举'} | √ | √
| enableEncSmallVideoStream  | 开启大小画面双路编码模式。 | {enable:'是否启用',smallVideoEncParam:'模式参数'} | √ | 
| setRemoteVideoStreamType  | 选定观看指定 uid 的大画面或小画面。 | {userId:'用户ID',streamType:'类型'} | √ | √
| setPriorRemoteVideoStreamType  | 设定观看方优先选择的视频质量。 | {streamType:'类型'} | √ | √
| muteLocalAudio  | 静音本地的音频。 | {mute:'是否静音'} | √ | √
| muteLocalVideo  | 关闭本地视频。 | {mute:'是否关闭'} | √ | √
| setAudioRoute  | 设置音频路由。 | {route:'模式'} | √ | √
| enableAudioVolumeEvaluation  | 启用音量大小提示。 | {intervalMs:'决定了 onUserVoiceVolume 回调的触发间隔，单位为ms，最小间隔为100ms，如果小于等于0则会关闭回调，建议设置为300ms；详细的回调规则请参考 onUserVoiceVolume 的注释说明。'} | √ | √
| startAudioRecording  | 开始录音。 | {filePath:'文件路径'} | √ | √
| stopAudioRecording  | 停止录音。 | - | √ | √
| setSystemVolumeType  | 设置通话时使用的系统音量类型。 | {type:'类型'} | √ | √
| enableAudioEarMonitoring  | 开启耳返。 | {enable:'是否启用'} | √ | √
| switchCamera  | 切换摄像头。 | - | √ | √
| isCameraZoomSupported  | 查询当前摄像头是否支持缩放。 | - | √ | √
| setZoom  | 设置摄像头缩放因子（焦距）。 | {distance:'焦距'} | √ | √
| isCameraTorchSupported  | 查询是否支持开关闪光灯（手电筒模式）。 | - | √ | √
| enableTorch  | 开启闪光灯 | {enable:'启用闪光灯'} | √ | √
| isCameraFocusPositionInPreviewSupported  | 查询是否支持设置焦点 | - | √ | √
| setFocusPosition  | 设置摄像头焦点 | {x:'',y:''} | √ | √
| isCameraAutoFocusFaceModeSupported  | 查询是否支持自动识别人脸位置 | - | √ | √

### 视图组件(TencentRtcVideoView)
#### 使用例子:
```dart
/// 本地预览:
TencentRtcVideoView(
    onViewCreated: (controller) {
        PermissionHandler().requestPermissions([PermissionGroup.camera]).then((res) {
        if (res[PermissionGroup.camera] != PermissionStatus.disabled) {
          controller.startLocalPreview(frontCamera: false);
        }
      });
    },
),

/// ...................

/// 远程预览:
TencentRtcVideoView(
    onViewCreated: (controller){
        controller.startRemoteView(userId: '用户ID');
    },
)
```
#### 相关接口:(TencentRtcVideoViewController调用方法)  
|  接口   | 说明  | 参数  | Android | IOS |
|  ----  | ----  | ----  | ----  | ----  |
| startRemoteView  | 开启远程显示 | {userId:'用户ID'} | √ | √
| stopRemoteView  | 停止远程显示 | {userId:'用户ID'} | √ | √
| startRemoteSubStreamView  | 开启远程辅流显示 | {userId:'用户ID'} | √ | √
| stopRemoteSubStreamView  | 停止远程辅流显示 | {userId:'用户ID'} | √ | √
| startLocalPreview  | 开启本地视频采集 | {frontCamera:'是否前置摄像头'} | √ | √
| stopLocalPreview  | 停止本地视频采集 | - | √ | √


## 使用
大部分方法直接基于腾讯云原始API，根据 TencentRtcPlugin 对象即可使用；部分视频相关内容，TencentRtcVideoView 需要配合 TencentRtcVideoViewControlle调用方法;  
例如进入房间只需要调用``TencentRtcPlugin.enterRoom()``即可，腾讯API文档地址:[https://cloud.tencent.com/document/product/647/32264](https://cloud.tencent.com/document/product/647/32264)  
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentRtcPlugin/1.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentRtcPlugin/2.png" height="300em" style="max-width:100%;display: inline-block;"/>

## 配置环境变量

1. 使用`flutter run --dart-define=USER_ID=userid`
2. 使用`vscode`debug配置，新建`.vscode/launch.json`:
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Flutter",
            "request": "launch",
            "type": "dart",
            "program": "${workspaceFolder}/example/lib/main.dart",
            "args": [
                "--dart-define=APP_ID=1234",
                "--dart-define=USER_ID=1234",
                "--dart-define=USER_SIG=asdf",
            ]
        }
    ]
}
```

## 其它插件
````
我同时维护的还有以下插件，如果您感兴趣与我一起进行维护，请通过Github联系我，欢迎 issues 和 PR。
````
| 平台 | 插件  |  描述  |  版本  |
| ---- | ----  | ---- |  ---- | 
| Flutter | [FlutterTencentImPlugin](https://github.com/JiangJuHong/FlutterTencentImPlugin)  | 腾讯云IM插件 | [![pub package](https://img.shields.io/pub/v/tencent_im_plugin.svg)](https://pub.dartlang.org/packages/tencent_im_plugin) | 
| Flutter | [FlutterTencentRtcPlugin](https://github.com/JiangJuHong/FlutterTencentRtcPlugin)  | 腾讯云Rtc插件 | [![pub package](https://img.shields.io/pub/v/tencent_rtc_plugin.svg)](https://pub.dartlang.org/packages/tencent_rtc_plugin) | 
| Flutter | [FlutterXiaoMiPushPlugin](https://github.com/JiangJuHong/FlutterXiaoMiPushPlugin)  | 小米推送SDK插件 | [![pub package](https://img.shields.io/pub/v/xiao_mi_push_plugin.svg)](https://pub.dartlang.org/packages/xiao_mi_push_plugin) | 
| Flutter | [FlutterHuaWeiPushPlugin](https://github.com/JiangJuHong/FlutterHuaWeiPushPlugin)  | 华为推送(HMS Push)插件 | [![pub package](https://img.shields.io/pub/v/hua_wei_push_plugin.svg)](https://pub.dartlang.org/packages/hua_wei_push_plugin) | 
| Flutter | [FlutterTextSpanField](https://github.com/JiangJuHong/FlutterTextSpanField)  | 自定义文本样式输入框 | [![pub package](https://img.shields.io/pub/v/text_span_field.svg)](https://pub.dartlang.org/packages/text_span_field) | 
| Flutter | [FlutterClipboardListener](https://github.com/JiangJuHong/FlutterClipboardListener)  | 粘贴板监听器 | [![pub package](https://img.shields.io/pub/v/clipboard_listener.svg)](https://pub.dartlang.org/packages/clipboard_listener) | 
| Flutter | [FlutterQiniucloudLivePlugin](https://github.com/JiangJuHong/FlutterQiniucloudLivePlugin)  | Flutter 七牛云直播云插件 | 暂未发布，通过 git 集成 | 
