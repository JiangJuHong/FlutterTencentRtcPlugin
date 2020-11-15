/// 音频采样率枚举
enum AudioSampleRateEnum {
  // 16k采样率
  Rate16000,
  // 32采样率
  Rate32000,
  // 44.1k采样率
  Rate44100,
  // 48k
  Rate48000,
}

class AudioSampleRateTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static AudioSampleRateEnum getByInt(int index) {
    switch (index) {
      case 16000:
        return AudioSampleRateEnum.Rate16000;
      case 32000:
        return AudioSampleRateEnum.Rate32000;
      case 44100:
        return AudioSampleRateEnum.Rate44100;
      case 48000:
        return AudioSampleRateEnum.Rate48000;
    }
    throw ArgumentError("参数异常");
  }
}
