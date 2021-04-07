import 'dart:convert';

/// 通用状态实体
class CommonStatusEntity {
  /// 状态码
  int? code;

  /// 状态描述
  String? msg;

  CommonStatusEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    code = json['code'];
    msg = json['msg'];
  }
}
