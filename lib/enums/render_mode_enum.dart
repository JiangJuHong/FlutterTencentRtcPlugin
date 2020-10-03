/// 渲染模式枚举
enum RenderModeEnum {
  // 装满
  Fill,
  // 固定
  Fit,
}

class RenderModeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(RenderModeEnum value) => value.index;
}
