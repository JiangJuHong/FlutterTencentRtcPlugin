/// 镜像类型枚举
enum MirrorTypeEnum {
  // SDK 决定镜像方式：前置摄像头镜像，后置摄像头不镜像
  Auto,
  // 前置摄像头和后置摄像头都镜像
  Enable,
  // 前置摄像头和后置摄像头都不镜像
  Disable,
}

class MirrorTypeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(MirrorTypeEnum value) => value.index;
}
