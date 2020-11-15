import 'dart:convert';

import 'package:tencent_rtc_plugin/entity/common_status_entity.dart';

/// 用户状态实体
class UserStatusEntity extends CommonStatusEntity {
  /// 用户ID
  String userId;

  UserStatusEntity.fromJson(data) : super.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
  }
}
