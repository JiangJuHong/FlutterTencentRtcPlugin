/// 角色枚举
enum RoleEnum {
  // 主播
  Anchor,
  // 观众
  Audience,
}

/// 角色工具类
class RoleTool {
  /// 转换为常量类型
  /// [value] 角色枚举
  /// [Return] 转换结果
  static int toInt(RoleEnum value) {
    switch (value) {
      case RoleEnum.Anchor:
        return 20;
      case RoleEnum.Audience:
        return 21;
    }
  }
}
