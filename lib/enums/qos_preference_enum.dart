/// 弱网下选择“保清晰”或“保流畅”
enum QosControlEnum {
  // 流畅
  Smooth,
  // 清晰
  Clear,
}

class QosControlTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(QosControlEnum value) {
    switch (value) {
      case QosControlEnum.Smooth:
        return 1;
      case QosControlEnum.Clear:
        return 2;
    }
    throw ArgumentError("参数异常");
  }
}
