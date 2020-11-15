enum PixelFormatEnum {
  /// 未知
  Unknown,

  /// YUV I420
  I420,

  /// OpenGL 2D 纹理
  Texture2D,
}

class PixelFormatTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(PixelFormatEnum value) => value.index;
}
