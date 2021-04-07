import 'dart:convert';

/// 自定义消息实体
class CustomMessageEntity {
  /// 用户ID
  String? userId;

  /// 数据流ID
  int? cmdID;

  /// 错误码，当前版本为-1
  int? errCode;

  /// 丢失的消息数量
  int? missed;

  CustomMessageEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    cmdID = json['cmdID'];
    errCode = json['errCode'];
    missed = json['missed'];
  }
}
