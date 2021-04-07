import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'controller/tencent_rtc_video_view_controller.dart';

/// 视频窗口
class TencentRtcVideoView extends StatefulWidget {
  /// 创建事件
  final ValueChanged<TencentRtcVideoViewController>? onViewCreated;

  const TencentRtcVideoView({Key? key, this.onViewCreated}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TencentRtcVideoViewState();
}

class TencentRtcVideoViewState extends State<TencentRtcVideoView> {
  /// 唯一标识符
  static const String type = "plugins.huic.top/tencentRtcVideoView";

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: type,
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: type,
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return Text("不支持的平台");
    }
  }

  /// 创建事件
  void _onPlatformViewCreated(int id) {
    if (widget.onViewCreated != null) {
      widget.onViewCreated!(TencentRtcVideoViewController(id));
    }
  }
}
