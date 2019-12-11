import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'enums/listener_type_enum.dart';

class TencentRtcPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tencent_rtc_plugin');

  /// 监听器对象
  static TencentRtcPluginListener listener;

  /// 添加消息监听
  static void addListener(ListenerValue func) {
    if (listener == null) {
      listener = TencentRtcPluginListener(_channel);
    }
    listener.addListener(func);
  }

  /// 移除消息监听
  static void removeListener(ListenerValue func) {
    if (listener == null) {
      listener = TencentRtcPluginListener(_channel);
    }
    listener.removeListener(func);
  }

  /// 加入房间(默认开启音频接收)
  static Future<void> enterRoom({
    @required int appid, // appid
    @required String userId, // 用户id
    @required String userSig, // 用户签名
    @required int roomId, // 房间号
    @required int scene,
  }) async {
    return await _channel.invokeMethod('enterRoom', {
      "appid": appid,
      "userId": userId,
      "userSig": userSig,
      "roomId": roomId,
      "scene": scene,
    });
  }

  /// 静音/取消静音
  static Future<void> muteRemoteAudio({
    @required String userId, // 用户id
    @required bool mute, // true静音，false静音
  }) async {
    return await _channel.invokeMethod('muteRemoteAudio', {
      "userId": userId,
      "mute": mute,
    });
  }

  /// 静音/取消静音 所有用户
  static Future<void> muteAllRemoteAudio({
    @required bool mute, // true静音，false静音
  }) async {
    return await _channel.invokeMethod('muteAllRemoteAudio', {
      "mute": mute,
    });
  }

  /// 设置远程视频填充模式
  static Future<void> setRemoteViewFillMode({
    @required String userId, // 用户ID
    @required int mode, // 模式
  }) async {
    return await _channel.invokeMethod('setRemoteViewFillMode', {
      "userId": userId,
      "mode": mode,
    });
  }
}

/// 监听器对象
class TencentRtcPluginListener {
  /// 监听器列表
  static Set<ListenerValue> listeners = Set();

  TencentRtcPluginListener(MethodChannel channel) {
    // 绑定监听器
    channel.setMethodCallHandler((methodCall) async {
      // 解析参数
      Map<String, dynamic> arguments = jsonDecode(methodCall.arguments);

      switch (methodCall.method) {
        case 'onListener':
          // 获得原始类型和参数
          String typeStr = arguments['type'];
          String paramsStr = arguments['params'];

          // 封装回调类型和参数
          ListenerTypeEnum type;
          Object params;

          // 初始化类型
          for (var item in ListenerTypeEnum.values) {
            if (item.toString().replaceFirst("ListenerTypeEnum.", "") ==
                typeStr) {
              type = item;
              break;
            }
          }

          // 没有找到类型就返回
          if (type == null) {
            throw MissingPluginException();
          }

          // 回调触发
          for (var item in listeners) {
            item(type, params ?? paramsStr);
          }

          break;
        default:
          throw MissingPluginException();
      }
    });
  }

  /// 添加消息监听
  void addListener(ListenerValue func) {
    listeners.add(func);
  }

  /// 移除消息监听
  void removeListener(ListenerValue func) {
    listeners.remove(func);
  }
}

/// 监听器值模型
typedef ListenerValue<P> = void Function(ListenerTypeEnum type, P params);
