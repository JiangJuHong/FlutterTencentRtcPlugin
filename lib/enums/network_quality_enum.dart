/// 网络质量枚举
enum NetworkQualityEnum {
  // 未知
  Unknown,
  // 最好
  Excellent,
  // 好
  Good,
  // 一般
  Poor,
  // 差
  Bad,
  // 很差
  Vbad,
  // 不可用
  Down,
}

class NetworkQualityTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(NetworkQualityEnum value) => value.index;

  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static NetworkQualityEnum getByInt(int index) => NetworkQualityEnum.values[index];
}
