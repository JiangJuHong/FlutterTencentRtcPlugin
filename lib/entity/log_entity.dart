import 'dart:convert';

import 'package:tencent_rtc_plugin/enums/log_level_enum.dart';

/// 日志实体
class LogEntity {
  /// 日志
  String? log;

  /// 级别
  LogLevelEnum? level;

  /// 模块
  String? module;

  LogEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    log = json['log'];
    level = LogLevelTool.getByInt(json['level']);
    module = json['module'];
  }
}
