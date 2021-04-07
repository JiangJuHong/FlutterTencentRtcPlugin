import 'dart:convert';

import 'package:tencent_rtc_plugin/enums/network_quality_enum.dart';

/// 网络质量实体
class NetworkQualityEntity {
  /// 本地网络质量
  UserQualityEntity? localQuality;

  /// 远程网络质量
  List<UserQualityEntity>? remoteQuality;

  NetworkQualityEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    localQuality = UserQualityEntity.fromJson(json['localQuality']);
    if (json['remoteQuality'] != null && json['remoteQuality'].length > 0) {
      List<UserQualityEntity> tempQuality = [];
      for (var d in json['remoteQuality']) {
        tempQuality.add(UserQualityEntity.fromJson(d));
      }
      remoteQuality = tempQuality;
    }
  }
}

/// 用户质量实体
class UserQualityEntity {
  /// 用户ID
  String? userId;

  /// 质量
  NetworkQualityEnum? quality;

  UserQualityEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    quality = NetworkQualityTool.getByInt(json['quality']);
  }
}
