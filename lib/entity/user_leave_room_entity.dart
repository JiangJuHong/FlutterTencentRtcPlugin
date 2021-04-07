import 'dart:convert';

/// 用户离开实体
class UserLeaveRoomEntity {
  /// 用户ID
  String? userId;

  /// 离开原因
  int? reason;

  UserLeaveRoomEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    reason = json['reason'];
  }
}
