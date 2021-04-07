import 'dart:convert';

/// 播放音效结束实体
class AudioEffectFinishedEntity {
  /// 音效ID
  int? effectId;

  /// 状态码
  int? code;

  AudioEffectFinishedEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    effectId = json['effectId'];
    code = json['code'];
  }
}
