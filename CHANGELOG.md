## 0.1.0
* 初始化项目，支持IOS和Android

## 0.1.1
* 修复IOS设备上回调数据非JSON类型时多了个 ""

## 0.1.2
* 修复JSON解析时的BUG

## 0.1.3
* 增加 setConsoleEnabled 和 showDebugView 接口
* 修复Android退出View后监听器不再生效的问题

## 0.1.4
* 修复Android监听器解析字符串多了一个 ""

## 0.1.5
* 增加toJSON拦截

## 0.1.6
* 修复toJSON拦截导致无法使用的问题

## 0.1.7
* 修复无法直接返回非字符串类型的数据

## 0.1.8
* 解决字符串数组序列化JSON时数据格式不正确的错误

## 0.1.9
* 增加 muteLocalVideo (关闭本地视频，感谢 @xb284524239 )
* 更新 JsonUtil 工具
* 字符异常的 MethodResult

## 0.1.10
* 合并代码，感谢 @maxi119 的贡献

## 0.1.11
* 进入房间方法增加 privateMapKey 参数