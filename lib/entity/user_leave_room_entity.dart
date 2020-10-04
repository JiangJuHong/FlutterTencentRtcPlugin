import 'dart:convert';

/// 用户离开实体
class CommonStatusEntity {
  /// 用户ID
  String userId;

  /// 离开原因
  int reason;

  CommonStatusEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data : jsonDecode(data);
    userId = json['userId'];
    reason = json['reason'];
  }
}
