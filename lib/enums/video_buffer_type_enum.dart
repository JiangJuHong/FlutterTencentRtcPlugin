enum VideoBufferTypeEnum {
  /// 未知
  Unknown,

  /// DirectBuffer，装载 I420 等 buffer，在 native 层使用
  ByteBuffer,

  /// byte[]，装载 I420 等 buffer，在 Java 层使用
  ByteArray,

  /// 直接操作纹理 ID，性能最好，画质损失最少
  Texture,
}

class VideoBufferTypeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(VideoBufferTypeEnum value) => value.index;
}
