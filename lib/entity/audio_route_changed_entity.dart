import 'dart:convert';

import 'package:tencent_rtc_plugin/enums/route_enum.dart';

/// 音频路由改变实体
class AudioRouteChangedEntity {
  /// 新路由
  RouteEnum newRoute;

  /// 旧路由
  RouteEnum oldRoute;

  AudioRouteChangedEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data : jsonDecode(data);
    newRoute = RouteTool.getByInt(json['newRoute']);
    oldRoute = RouteTool.getByInt(json['oldRoute']);
  }
}
