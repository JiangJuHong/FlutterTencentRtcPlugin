import 'dart:convert';

/// 用户音量实体
class VoiceVolumeEntity {
  /// 状态码
  int totalVolume;

  /// 状态描述
  List<UserVoiceVolumeEntity> userVolumes;

  VoiceVolumeEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    totalVolume = json['totalVolume'];
    if (json['userVolumes'] != null && json['userVolumes'].length > 0) {
      List<UserVoiceVolumeEntity> tempData = [];
      for (var d in json['userVolumes']) {
        tempData.add(UserVoiceVolumeEntity.fromJson(d));
      }
      userVolumes = tempData;
    }
  }
}

/// 用户语音音量实体
class UserVoiceVolumeEntity {
  /// 用户ID
  String userId;

  /// 音量
  int volume;

  UserVoiceVolumeEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userId = json['userId'];
    volume = json['volume'];
  }
}
