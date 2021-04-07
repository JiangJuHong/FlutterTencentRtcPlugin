import 'dart:convert';
import 'dart:typed_data';

import 'package:tencent_rtc_plugin/enums/audio_sample_rate_enum.dart';

/// 音频数据实体
class AudioFrameEntity {
  /// 用户ID
  String? userId;

  /// 数据流
  Uint8List? data;

  /// 通道
  int? channel;

  /// 采样率
  AudioSampleRateEnum? sampleRate;

  /// 时间
  int? timestamp;

  AudioFrameEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    this.data = json['data'];
    this.userId = json['userId'];
    this.channel = json['channel'];
    if (json['sampleRate'] != null)
      this.sampleRate = AudioSampleRateTool.getByInt(json['sampleRate']);
    this.timestamp = json['timestamp'];
  }
}
