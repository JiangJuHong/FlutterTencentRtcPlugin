/// Debug视图模式枚举
enum DebugViewModeEnum {
  // 不显示
  Hide,
  // 精简版
  Simple,
  // 完整版
  Full,
}

class DebugViewModeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(DebugViewModeEnum value) => value.index;
}
