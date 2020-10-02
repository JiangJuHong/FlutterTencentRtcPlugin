/// 视频分辨率（云端控制 - 客户端控制）
enum QosControlEnum {
  // 客户端
  Client,
  // 清晰
  Server,
}

class QosControlTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(QosControlEnum value) => value.index;
}
