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

  // 开启远端辅流显示
  Future<void> startRemoteSubStreamView({
    @required String userId,
  }) async {
    return _channel.invokeMethod("startRemoteSubStreamView", {
      "userId": userId,
    });
  }

  // 关闭远端辅流显示
  Future<void> stopRemoteSubStreamView({
    @required String userId,
  }) async {
    return _channel.invokeMethod("stopRemoteSubStreamView", {
      "userId": userId,
    });
  }

  /// 开启本地视频采集
  Future<void> startLocalPreview({
    @required bool frontCamera, // true：前置摄像头；false：后置摄像头。
  }) async {
    return _channel.invokeMethod('startLocalPreview', {
      "frontCamera": frontCamera,
    });
  }

  /// 停止本地视频采集
  Future<void> stopLocalPreview() async {
    return _channel.invokeMethod('stopLocalPreview');
  }
}
