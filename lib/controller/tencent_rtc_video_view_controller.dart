import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// 视图控制器
class TencentRtcVideoViewController {
  TencentRtcVideoViewController(int id) : _channel = new MethodChannel('plugins.huic.top/tencentRtcVideoView_$id');

  final MethodChannel _channel;

  /// 开启本地视频采集
  /// [frontCamera] 是否是前置摄像头
  startLocalPreview({@required bool frontCamera}) => _channel.invokeMethod('startLocalPreview', {"frontCamera": frontCamera});

  /// 开启远程显示
  /// [userId] 用户ID
  startRemoteView({@required String userId}) => _channel.invokeMethod('startRemoteView', {"userId": userId});

  /// 开启远端辅流显示
  /// [userId] 用户ID
  startRemoteSubStreamView({@required String userId}) => _channel.invokeMethod("startRemoteSubStreamView", {"userId": userId});
}
