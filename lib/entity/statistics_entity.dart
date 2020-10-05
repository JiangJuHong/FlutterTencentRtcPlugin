import 'dart:convert';

import 'package:tencent_rtc_plugin/enums/resolution_enum.dart';
import 'package:tencent_rtc_plugin/enums/resolution_mode_enum.dart';
import 'package:tencent_rtc_plugin/enums/stream_type_enum.dart';

/// 指标实体
class StatisticsEntity {
  /// 当前 App 的 CPU 使用率（％）
  int appCpu;

  /// 当前系统的 CPU 使用率（％）
  int systemCpu;

  /// 延迟（毫秒）， 指 SDK 到腾讯云服务器的一次网络往返时间，该值越小越好。 一般低于50ms的 rtt 相对理想，而高于100ms的 rtt 会引入较大的通话延时。 由于数据上下行共享一条网络连接，所以 local 和 remote 的 rtt 相同。
  int rtt;

  /// C -> S 上行丢包率（％），该值越小越好，例如，丢包率为0表示网络很好， 丢包率为30%则意味着 SDK 向服务器发送的数据包中会有30%丢失在上行传输中
  int upLoss;

  /// S -> C 下行丢包率（％），该值越小越好，例如，丢包率为0表示网络很好， 丢包率为30%则意味着 SDK 向服务器发送的数据包中会有30%丢失在下行传输中
  int downLoss;

  /// 发送字节总数，注意是字节数（bytes），不是比特数（bits）
  int sendBytes;

  /// 接收字节总数，注意是字节数（bytes），不是比特数（bits）
  int receiveBytes;

  /// 自己本地的音视频统计信息，可能有主画面、小画面以及辅路画面等多路的情况，因此是一个数组
  List<LocalStatisticsEntity> localArray;

  /// 远端成员的音视频统计信息，可能有主画面、小画面以及辅路画面等多路的情况，因此是一个数组
  List<RemoteStatisticsEntity> remoteArray;

  StatisticsEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data : jsonDecode(data);
    appCpu = json['appCpu'];
    systemCpu = json['systemCpu'];
    rtt = json['rtt'];
    upLoss = json['upLoss'];
    downLoss = json['downLoss'];
    sendBytes = json['sendBytes'];
    receiveBytes = json['receiveBytes'];
    if (json['localArray'] != null && json['localArray'].length > 0) {
      List<LocalStatisticsEntity> tempData = [];
      for (var d in json['localArray']) {
        tempData.add(LocalStatisticsEntity.fromJson(d));
      }
      localArray = tempData;
    }
    if (json['remoteArray'] != null && json['remoteArray'].length > 0) {
      List<RemoteStatisticsEntity> tempData = [];
      for (var d in json['remoteArray']) {
        tempData.add(RemoteStatisticsEntity.fromJson(d));
      }
      remoteArray = tempData;
    }
  }
}

/// 本地指标实体
class LocalStatisticsEntity {
  /// 视频宽度
  int width;

  /// 视频高度
  int height;

  /// 帧率fps
  int frameRate;

  /// 视频发送码率（Kbps）
  int videoBitrate;

  /// 音频采样率（Hz）
  int audioSampleRate;

  /// 音频发送码率（Kbps）
  int audioBitrate;

  /// 流类型（大画面 | 小画面 | 辅路画面）
  StreamTypeEnum streamType;

  LocalStatisticsEntity.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    frameRate = json['frameRate'];
    videoBitrate = json['videoBitrate'];
    audioSampleRate = json['audioSampleRate'];
    audioBitrate = json['audioBitrate'];
    streamType = StreamTypeTool.getByInt(json['streamType']);
  }
}

/// 远程指标实体
class RemoteStatisticsEntity {
  /// 用户ID
  String userId;

  /// 该线路的总丢包率（％），该值越小越好，例如，丢包率为0表示网络很好， 丢包率是该线路的 userId 从上行到服务器再到下行的总丢包率。 如果 downLoss 为0, 但是 finalLoss 不为0，说明该 userId 在上行就出现了无法恢复的丢包
  int finalLoss;

  /// 视频宽度
  int width;

  /// 视频高度
  int height;

  /// 帧率fps
  int frameRate;

  /// 视频发送码率（Kbps）
  int videoBitrate;

  /// 音频采样率（Hz）
  int audioSampleRate;

  /// 音频发送码率（Kbps）
  int audioBitrate;

  /// 播放时延（ms）
  int jitterBufferDelay;

  /// 流类型（大画面 | 小画面 | 辅路画面）
  StreamTypeEnum streamType;

  RemoteStatisticsEntity.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    finalLoss = json['finalLoss'];
    width = json['width'];
    height = json['height'];
    frameRate = json['frameRate'];
    videoBitrate = json['videoBitrate'];
    audioSampleRate = json['audioSampleRate'];
    audioBitrate = json['audioBitrate'];
    jitterBufferDelay = json['jitterBufferDelay'];
    streamType = StreamTypeTool.getByInt(json['streamType']);
  }
}
