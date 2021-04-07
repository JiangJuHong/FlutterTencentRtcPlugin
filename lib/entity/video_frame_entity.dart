import 'dart:convert';

import 'package:tencent_rtc_plugin/enums/stream_type_enum.dart';

/// 视频渲染实体
class VideoFrameEntity {
  /// 用户ID
  String? userId;

  /// 流类型
  StreamTypeEnum? streamType;

  /// 宽度
  int? width;

  /// 高度
  int? height;

  VideoFrameEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    streamType = StreamTypeTool.getByInt(json['streamType']);
    width = json['width'];
    height = json['height'];
  }
}
