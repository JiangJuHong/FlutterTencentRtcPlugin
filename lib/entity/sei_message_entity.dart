import 'dart:convert';

/// Sei消息实体
class SeiMessageEntity {
  /// 用户ID
  String userId;

  /// 数据内容
  String data;

  SeiMessageEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    data = json['data'];
  }
}
