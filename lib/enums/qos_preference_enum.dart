/// 弱网下选择“保清晰”或“保流畅”
enum QosPreferenceEnum {
  // 流畅
  Smooth,
  // 清晰
  Clear,
}

class QosPreferenceTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(QosPreferenceEnum value) {
    switch (value) {
      case QosPreferenceEnum.Smooth:
        return 1;
      case QosPreferenceEnum.Clear:
        return 2;
    }
    throw ArgumentError("参数异常");
  }
}
