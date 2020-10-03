/// 重力感应枚举
enum GsensorModeEnum {
  // 关闭重力感应。
  Disable,
  // 开启重力感应，默认值。
  UiautoLayout,
  // 待废弃，效果等同于 UIAutoLayout。
  UifixLayout,
}

class GsensorModeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(GsensorModeEnum value) => value.index;
}
