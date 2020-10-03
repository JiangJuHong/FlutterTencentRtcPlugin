/// 旋转角度枚举
enum RotationEnum {
  Rotation_0,
  Rotation_90,
  Rotation_180,
  Rotation_270,
}

class RotationTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(RotationEnum value) => value.index;
}
