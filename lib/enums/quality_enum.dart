/// 质量枚举
enum QualityEnum {
  // 流畅音质：采样率：16k；单声道；音频裸码率：16kbps；适合语音通话为主的场景，比如在线会议，语音通话。
  Speech,
  // 默认音质：采样率：48k；单声道；音频裸码率：50kbps；SDK 默认的音频质量，如无特殊需求推荐选择之。
  Default,
  // 高音质：采样率：48k；双声道 + 全频带；音频裸码率：128kbps；适合需要高保真传输音乐的场景，比如K歌、音乐直播等。
  Music,
}

class QualityTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(QualityEnum value) {
    switch (value) {
      case QualityEnum.Speech:
        return 1;
      case QualityEnum.Default:
        return 2;
      case QualityEnum.Music:
        return 3;
    }
    throw ArgumentError("参数异常");
  }
}
