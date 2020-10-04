import 'dart:convert';

import 'package:tencent_rtc_plugin/enums/network_quality_enum.dart';
import 'package:tencent_rtc_plugin/enums/stream_type_enum.dart';

/// 网络测速实体
class SpeedTestEntity {
  /// 当前完成的测速结果
  SpeedTestResultEntity currentResult;

  /// 已完成测速的服务器数量
  int finishedCount;

  /// 需要测速的服务器总数量
  int totalCount;

  SpeedTestEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data : jsonDecode(data);
    currentResult = SpeedTestResultEntity.fromJson(json['currentResult']);
    finishedCount = json['finishedCount'];
    totalCount = json['totalCount'];
  }
}

/// 网络测速结果实体
class SpeedTestResultEntity {
  /// IP地址
  String ip;

  /// 网络质量
  NetworkQualityEnum quality;

  /// 上行丢包率，范围是0 - 1.0，例如，0.3代表每向服务器发送10个数据包，可能有3个会在中途丢失。
  double upLostRate;

  /// 下行丢包率，范围是0 - 1.0，例如，0.2表示每从服务器收取10个数据包可能会在中途丢失2个。
  double downLostRate;

  /// 延迟（毫秒），指当前设备到腾讯云服务器的一次网络往返时间，该值越小越好，正常数值范围是10ms - 100ms
  int rtt;

  SpeedTestResultEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data : jsonDecode(data);
    ip = json['ip'];
    quality = NetworkQualityTool.getByInt(json['quality']);
    upLostRate = json['upLostRate'];
    downLostRate = json['downLostRate'];
    rtt = json['rtt'];
  }
}
