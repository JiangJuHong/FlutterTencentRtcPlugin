import 'dart:convert';

import 'dart:typed_data';

/// 自定义消息接收实体
class CustomMessageReceiveEntity {
  /// 用户ID
  String userId;

  /// 数据流ID
  int cmdID;

  ///消息体
  Uint8List message;

  int seq;

  CustomMessageReceiveEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    cmdID = json['cmdID'];
    message = json['message'];
    seq = json['seq'];
  }
}
