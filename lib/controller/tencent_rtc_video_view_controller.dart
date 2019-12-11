import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// 视图控制器
class TencentRtcVideoViewController {
  TencentRtcVideoViewController(int id)
      : _channel =
            new MethodChannel('plugins.huic.top/tencentRtcVideoView_$id');

  final MethodChannel _channel;

  /// 开启远程显示
  Future<void> startRemoteView({
    @required String userId, // 用户ID
  }) async {
    return _channel.invokeMethod('startRemoteView', {
      "userId": userId,
    });
  }

  /// 关闭远程显示
  Future<void> stopRemoteView({
    @required String userId, // 用户ID
  }) async {
    return _channel.invokeMethod('stopRemoteView', {
      "userId": userId,
    });
  }
}
