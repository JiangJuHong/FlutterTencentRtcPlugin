/// 分辨率枚举
enum ResolutionEnum {
  r120x120,
  r160x160,
  r270x270,
  r480x480,
  r160x120,
  r240x180,
  r280x210,
  r320x240,
  r400x300,
  r480x360,
  r640x480,
  r960x720,
  r160x90,
  r256x144,
  r320x180,
  r480x270,
  r640x360,
  r960x540,
  r1280x720,
  r1920x1080,
}

/// 分辨率模式工具类
class ResolutionTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(ResolutionEnum value) {
    switch (value) {
      case ResolutionEnum.r120x120:
        return 1;
      case ResolutionEnum.r160x160:
        return 3;
      case ResolutionEnum.r270x270:
        return 5;
      case ResolutionEnum.r480x480:
        return 7;
      case ResolutionEnum.r160x120:
        return 50;
      case ResolutionEnum.r240x180:
        return 52;
      case ResolutionEnum.r280x210:
        return 54;
      case ResolutionEnum.r320x240:
        return 56;
      case ResolutionEnum.r400x300:
        return 58;
      case ResolutionEnum.r480x360:
        return 60;
      case ResolutionEnum.r640x480:
        return 62;
      case ResolutionEnum.r960x720:
        return 64;
      case ResolutionEnum.r160x90:
        return 100;
      case ResolutionEnum.r256x144:
        return 102;
      case ResolutionEnum.r320x180:
        return 104;
      case ResolutionEnum.r480x270:
        return 106;
      case ResolutionEnum.r640x360:
        return 108;
      case ResolutionEnum.r960x540:
        return 110;
      case ResolutionEnum.r1280x720:
        return 112;
      case ResolutionEnum.r1920x1080:
        return 114;
    }
  }
}
