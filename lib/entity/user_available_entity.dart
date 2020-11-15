import 'dart:convert';

/// 用户状态实体
class UserAvailableEntity {
  /// 用户ID
  String userId;

  /// 状态
  bool available;

  UserAvailableEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    available = json['available'];
  }
}
