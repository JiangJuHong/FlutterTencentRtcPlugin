import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'entity/video_enc_param_entity.dart';
import 'enums/listener_type_enum.dart';

class TencentRtcPlugin {
  static const MethodChannel _channel = const MethodChannel('tencent_rtc_plugin');

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

  /// 设置Debug视图
  static Future<void> showDebugView({
    @required int mode, // 模式
  }) async {
    return await _channel.invokeMethod('showDebugView', {
      "mode": mode,
    });
  }

  /// 设置启用控制台打印
  static Future<void> setConsoleEnabled({
    @required bool enabled, // 是否启用
  }) async {
    return await _channel.invokeMethod('setConsoleEnabled', {
      "enabled": enabled,
    });
  }

  /// 加入房间(默认开启音频接收)
  static Future<void> enterRoom({
    @required int appid, // appid
    @required String userId, // 用户id
    @required String userSig, // 用户签名
    @required int roomId, // 房间号
    @required int scene, // 应用场景，目前支持视频通话（VideoCall）和在线直播（Live）两种场景。
    int role, // 角色
    String privateMapKey, // 房间签名 [非必填]
  }) async {
    return await _channel.invokeMethod('enterRoom', {
      "appid": appid,
      "userId": userId,
      "userSig": userSig,
      "roomId": roomId,
      "scene": scene,
      "role": role,
      "privateMapKey": privateMapKey,
    });
  }

  /// 离开房间
  static Future<void> exitRoom() async {
    return await _channel.invokeMethod('exitRoom');
  }

  /// 切换角色，仅适用于直播场景（TRTCAppSceneLIVE）。
  static Future<void> switchRole({
    @required int role, // 目标角色
  }) async {
    return await _channel.invokeMethod('switchRole', {
      "role": role,
    });
  }

  /// 设置音视频数据接收模式（需要在进房前设置才能生效）。
  /// 默认进房后自动接收音视频
  static Future<void> setDefaultStreamRecvMode({
    @required bool autoRecvAudio, // true：自动接收音频数据；false：需要调用 muteRemoteAudio 进行请求或取消。默认值：true。
    @required bool autoRecvVideo, // true：自动接收视频数据；false：需要调用 startRemoteView/stopRemoteView 进行请求或取消。默认值：true。
  }) async {
    return await _channel.invokeMethod('setDefaultStreamRecvMode', {
      "autoRecvAudio": autoRecvAudio,
      "autoRecvVideo": autoRecvVideo,
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

  /// 设置本地视频填充模式
  static Future<void> setLocalViewFillMode({
    @required int mode, // 模式
  }) async {
    return await _channel.invokeMethod('setLocalViewFillMode', {
      "mode": mode,
    });
  }

  /// 开启本地音频采集
  static Future<void> startLocalAudio() async {
    return await _channel.invokeMethod('startLocalAudio');
  }

  /// 关闭本地音频采集
  static Future<void> stopLocalAudio() async {
    return await _channel.invokeMethod('stopLocalAudio');
  }

  /// 停止显示所有远端视频画面。
  static Future<void> stopAllRemoteView() async {
    return _channel.invokeMethod('stopAllRemoteView');
  }

  /// 暂停接收指定的远端视频流。。
  static Future<void> muteRemoteVideoStream({
    @required String userId, // 用户ID
    @required bool mute, // 是否停止接收
  }) async {
    return _channel.invokeMethod('muteRemoteVideoStream', {
      "userId": userId,
      "mute": mute,
    });
  }

  /// 停止接收所有远端视频流
  static Future<void> muteAllRemoteVideoStreams({
    @required bool mute, // 是否停止接收
  }) async {
    return _channel.invokeMethod('muteAllRemoteVideoStreams', {
      "mute": mute,
    });
  }

  /// 设置视频编码相关
  static Future<void> setVideoEncoderParam({
    @required VideoEncParamEntity param, // 视频编码参数，详情请参考 TRTCCloudDef.java 中的 TRTCVideoEncParam 定义。
  }) async {
    return _channel.invokeMethod('setVideoEncoderParam', {
      "param": param.toJson(),
    });
  }

  /// 设置网络流控相关参数。
  static Future<void> setNetworkQosParam({
    @required int preference, // 弱网下是“保清晰”还是“保流畅”。
    @required int controlMode, // 视频分辨率（云端控制 - 客户端控制）。
  }) async {
    return _channel.invokeMethod('setNetworkQosParam', {
      "preference": preference,
      "controlMode": controlMode,
    });
  }

  /// 设置本地图像的顺时针旋转角度。
  static Future<void> setLocalViewRotation({
    @required int rotation, // rotation 支持 TRTC_VIDEO_ROTATION_90、TRTC_VIDEO_ROTATION_180、TRTC_VIDEO_ROTATION_270 旋转角度，默认值：TRTC_VIDEO_ROTATION_0。。
  }) async {
    return _channel.invokeMethod('setLocalViewRotation', {
      "rotation": rotation,
    });
  }

  /// 设置远端图像的顺时针旋转角度。
  static Future<void> setRemoteViewRotation({
    @required String userId, // 用户ID
    @required int rotation, // rotation 支持 TRTC_VIDEO_ROTATION_90、TRTC_VIDEO_ROTATION_180、TRTC_VIDEO_ROTATION_270 旋转角度，默认值：TRTC_VIDEO_ROTATION_0。。
  }) async {
    return _channel.invokeMethod('setRemoteViewRotation', {
      "userId": userId,
      "rotation": rotation,
    });
  }

  /// 设置视频编码输出的（也就是远端用户观看到的，以及服务器录制下来的）画面方向
  static Future<void> setVideoEncoderRotation({
    @required int rotation, // 目前支持 TRTC_VIDEO_ROTATION_0 和 TRTC_VIDEO_ROTATION_180 两个旋转角度，默认值：TRTC_VIDEO_ROTATION_0。
  }) async {
    return _channel.invokeMethod('setVideoEncoderRotation', {
      "rotation": rotation,
    });
  }

  /// 设置本地摄像头预览画面的镜像模式。
  static Future<void> setLocalViewMirror({
    @required int mirrorType, // mirrorType TRTC_VIDEO_MIRROR_TYPE_AUTO：SDK 决定镜像方式：前置摄像头镜像，后置摄像头不镜像。 TRTC_VIDEO_MIRROR_TYPE_ENABLE：前置摄像头和后置摄像头都镜像。 TRTC_VIDEO_MIRROR_TYPE_DISABLE：前置摄像头和后置摄像头都不镜像。 默认值：TRTC_VIDEO_MIRROR_TYPE_AUTO。
  }) async {
    return _channel.invokeMethod('setLocalViewMirror', {
      "mirrorType": mirrorType,
    });
  }

  /// 设置编码器输出的画面镜像模式。
  static Future<void> setVideoEncoderMirror({
    @required bool mirror, // true：镜像；false：不镜像；默认值：false。
  }) async {
    return _channel.invokeMethod('setVideoEncoderMirror', {
      "mirror": mirror,
    });
  }

  /// 设置重力感应的适应模式。
  static Future<void> setGSensorMode({
    @required int mode, // 重力感应模式，详情请参考 TRTC_GSENSOR_MODE 的定义，默认值：TRTC_GSENSOR_MODE_UIFIXLAYOUT。
  }) async {
    return _channel.invokeMethod('setGSensorMode', {
      "mode": mode,
    });
  }

  /// 开启大小画面双路编码模式。
  static Future<void> enableEncSmallVideoStream({
    @required bool enable, // 是否开启小画面编码，默认值：false。
    @required VideoEncParamEntity smallVideoEncParam, // 小流的视频参数。
  }) async {
    return _channel.invokeMethod('enableEncSmallVideoStream', {
      "enable": enable,
      "smallVideoEncParam": smallVideoEncParam.toJson(),
    });
  }

  /// 选定观看指定 uid 的大画面或小画面。
  static Future<void> setRemoteVideoStreamType({
    @required String userId, // 用户ID
    @required int streamType, // 视频流类型，即选择看大画面或小画面，默认为大画面。
  }) async {
    return _channel.invokeMethod('setRemoteVideoStreamType', {
      "userId": userId,
      "streamType": streamType,
    });
  }

  /// 设定观看方优先选择的视频质量。
  static Future<void> setPriorRemoteVideoStreamType({
    @required int streamType, // 默认观看大画面或小画面，默认为大画面。
  }) async {
    return _channel.invokeMethod('setPriorRemoteVideoStreamType', {
      "streamType": streamType,
    });
  }

  /// 静音本地的音频。
  static Future<void> muteLocalAudio({
    @required bool mute, // true：屏蔽；false：开启，默认值：false。
  }) async {
    return _channel.invokeMethod('muteLocalAudio', {
      "mute": mute,
    });
  }

  /// 关闭本地的视频。
  static Future<void> muteLocalVideo({
    @required bool mute, // true：屏蔽；false：开启，默认值：false。
  }) async {
    return _channel.invokeMethod('muteLocalVideo', {
      "mute": mute,
    });
  }

  /// 设置音频路由。
  static Future<void> setAudioRoute({
    @required int route, // 音频路由，即声音由哪里输出（扬声器、听筒），请参考
  }) async {
    return _channel.invokeMethod('setAudioRoute', {
      "route": route,
    });
  }

  /// 启用音量大小提示。
  static Future<void> enableAudioVolumeEvaluation({
    @required int intervalMs, // 决定了 onUserVoiceVolume 回调的触发间隔，单位为ms，最小间隔为100ms，如果小于等于0则会关闭回调，建议设置为300ms；详细的回调规则请参考 onUserVoiceVolume 的注释说明。
  }) async {
    return _channel.invokeMethod('enableAudioVolumeEvaluation', {
      "intervalMs": intervalMs,
    });
  }

  /// 开始录音。
  static Future<void> startAudioRecording({
    @required String filePath, // 文件路径（必填），录音的文件地址，由用户自行指定，请确保 App 里指定的目录存在且可写。
  }) async {
    return _channel.invokeMethod('startAudioRecording', {
      "filePath": filePath,
    });
  }

  /// 停止录音。
  static Future<void> stopAudioRecording() async {
    return _channel.invokeMethod('stopAudioRecording');
  }

  /// 设置通话时使用的系统音量类型。
  static Future<void> setSystemVolumeType({
    @required int type, // 系统音量类型，请参考 TRTCSystemVolumeType，默认值：TRTCSystemVolumeTypeAuto。
  }) async {
    return _channel.invokeMethod('setSystemVolumeType', {
      "type": type,
    });
  }

  /// 开启耳返。
  static Future<void> enableAudioEarMonitoring({
    @required bool enable, // true：开启；false：关闭。
  }) async {
    return _channel.invokeMethod('enableAudioEarMonitoring', {
      "enable": enable,
    });
  }

  /// 切换摄像头。
  static Future<void> switchCamera() async {
    return _channel.invokeMethod('switchCamera');
  }

  /// 查询当前摄像头是否支持缩放
  Future<bool> isCameraZoomSupported() async {
    return _channel.invokeMethod('isCameraZoomSupported');
  }

  /// 设置摄像头缩放因子（焦距）。
  static Future<void> setZoom({
    @required int distance, // 取值范围为1 - 5，数值越大，焦距越远。
  }) async {
    return _channel.invokeMethod('setZoom', {
      "distance": distance,
    });
  }

  /// 查询是否支持开关闪光灯（手电筒模式）。
  Future<bool> isCameraTorchSupported() async {
    return _channel.invokeMethod('isCameraTorchSupported');
  }

  /// 开关闪光灯。
  static Future<void> enableTorch({
    @required bool enable, // true：开启；false：关闭，默认值：false。
  }) async {
    return _channel.invokeMethod('enableTorch', {
      "enable": enable,
    });
  }

  /// 查询是否支持设置焦点。
  Future<bool> isCameraFocusPositionInPreviewSupported() async {
    return _channel.invokeMethod('isCameraFocusPositionInPreviewSupported');
  }

  /// 设置摄像头焦点。
  static Future<void> setFocusPosition({
    @required int x,
    @required int y,
  }) async {
    return _channel.invokeMethod('setFocusPosition', {
      "x": x,
      "y": y,
    });
  }

  /// 查询是否支持自动识别人脸位置。
  Future<bool> isCameraAutoFocusFaceModeSupported() async {
    return _channel.invokeMethod('isCameraAutoFocusFaceModeSupported');
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
          var params = arguments['params'];

          // 封装回调类型和参数
          ListenerTypeEnum type;

          // 初始化类型
          for (var item in ListenerTypeEnum.values) {
            if (item.toString().replaceFirst("ListenerTypeEnum.", "") == typeStr) {
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
            item(type, params);
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
