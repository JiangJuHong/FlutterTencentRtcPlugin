/// 分辨率模式枚举
enum ResolutionModeEnum {
  Landscape,
  Portrait,
}

/// 分辨率模式工具类
class ResolutionModeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(ResolutionModeEnum value) => value.index;
}
