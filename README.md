<div align="center">

[![](https://img.shields.io/badge/flutter2.0-NullSafety-1)](#)
[![](https://img.shields.io/pub/v/tencent_rtc_plugin.svg)](https://pub.dartlang.org/packages/tencent_rtc_plugin)
[![](https://img.shields.io/badge/Version-社区版-1)](#)
[![](https://img.shields.io/github/license/JiangJuHong/FlutterTencentRtcPlugin)](https://www.apache.org/licenses/LICENSE-2.0)
[![](https://img.shields.io/badge/qq群-850923396-1)](https://jq.qq.com/?_wv=1027&k=QxCWMlUf)

</div>

# What is FlutterTencentRTC ？

FlutterTencentRTC是基于[腾讯云TRTC](https://cloud.tencent.com/product/trtc)服务进行的Flutter封装，为Flutter提供实时音视频服务.

# 终章
## 致所有FlutterTencentRtcPlugin贡献者及用户
````
即日起，FlutterTencentRtcPlugin停止维护，永久保留仓库代码。感谢所有贡献者的帮助，同时感谢所有用户长期以来的支持。
如果您的项目中还需要集成FlutterTRTC服务，请移至: https://pub.dev/packages/tencent_trtc_cloud。
关闭说明:
    1. 腾讯终于推出了官方SDK，维护更稳定，推荐使用
    2. 官方SDK使用方式和此插件一致，通过此插件升级到官方SDK不存在兼容性问题，语法变更不大

一个项目的征途结束了，开源的步伐永远不滞。
欢迎加入Flutter讨论群，QQ群号: 850923396
````

# 官方版和社区版的区别

* 两者的区别：本质上官方版和社区版都是基于IM的SDK进行封装，官方版的更偏向三端写法类似(Android、IOS、Flutter)，社区版则提供更便捷的使用方式(1分钟上手即用)(例: FlutterTencentRTC.enterRoom)。
* 该如何选择：根据个人编码习惯选择即可。
* 维护的周期：社区版和官方版均在持续迭代，发现异常将会在第一时间进行修复。

# Links

* [Document](https://www.yuque.com/jiangjuhong/tencnet-rtc-flutter/vdzkus)
* [Chat](https://jq.qq.com/?_wv=1027&k=QxCWMlUf)
* [Sponsor](https://www.yuque.com/jiangjuhong/krioix/kw8zq2)

# Customization

如果您的项目有定制化需求，可通过QQ(690717394) 或 邮箱(690717394@qq.com) 联系我，该项服务为有偿服务，具体价格根据需求量进行决定。

# Other Plugins

````
我同时维护的还有以下插件，如果您感兴趣与我一起进行维护，请通过Github联系我，欢迎 issues 和 PR。
````

| 平台     | 插件                                                                                      | 描述                      | 版本                                                                                                                                 |
|:--------|:------------------------------------------------------------------------------------------|:-------------------------|:------------------------------------------------------------------------------------------------------------------------------------|
| Flutter | [FlutterVideoPlayerLibrary-Desc](https://github.com/JiangJuHong/FlutterVideoPlayerLibrary-Desc) | Flutter 最好用的播放器(UI库) | - |
| Flutter | [FlutterPerfectVolumeControl](https://github.com/JiangJuHong/FlutterPerfectVolumeControl) | Flutter 完美的音量控制器插件 | [![pub package](https://img.shields.io/pub/v/perfect_volume_control.svg)](https://pub.dartlang.org/packages/perfect_volume_control) |
| Flutter | [FlutterTencentImPlugin](https://github.com/JiangJuHong/FlutterTencentImPlugin)           | 腾讯云IM插件               | [![pub package](https://img.shields.io/pub/v/tencent_im_plugin.svg)](https://pub.dartlang.org/packages/tencent_im_plugin)           |
| Flutter | [FlutterTencentRtcPlugin](https://github.com/JiangJuHong/FlutterTencentRtcPlugin)         | 腾讯云Rtc插件              | [![pub package](https://img.shields.io/pub/v/tencent_rtc_plugin.svg)](https://pub.dartlang.org/packages/tencent_rtc_plugin)         |
| Flutter | [FlutterXiaoMiPushPlugin](https://github.com/JiangJuHong/FlutterXiaoMiPushPlugin)         | 小米推送SDK插件            | [![pub package](https://img.shields.io/pub/v/xiao_mi_push_plugin.svg)](https://pub.dartlang.org/packages/xiao_mi_push_plugin)       |
| Flutter | [FlutterHuaWeiPushPlugin](https://github.com/JiangJuHong/FlutterHuaWeiPushPlugin)         | 华为推送(HMS Push)插件     | [![pub package](https://img.shields.io/pub/v/hua_wei_push_plugin.svg)](https://pub.dartlang.org/packages/hua_wei_push_plugin)       |
| Flutter | [FlutterTextSpanField](https://github.com/JiangJuHong/FlutterTextSpanField)               | 自定义文本样式输入框         | [![pub package](https://img.shields.io/pub/v/text_span_field.svg)](https://pub.dartlang.org/packages/text_span_field)               |
| Flutter | [FlutterClipboardListener](https://github.com/JiangJuHong/FlutterClipboardListener)       | 粘贴板监听器               | [![pub package](https://img.shields.io/pub/v/clipboard_listener.svg)](https://pub.dartlang.org/packages/clipboard_listener)         |
| Flutter | [FlutterQiniucloudLivePlugin](https://github.com/JiangJuHong/FlutterQiniucloudLivePlugin) | Flutter 七牛云直播云插件    | 暂未发布，通过 git 集成                                                                                                                          |

