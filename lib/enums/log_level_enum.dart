/// 日志输出级别枚举
enum LogLevelEnum {
  // 输出所有级别的 Log
  Verbose,
  // 输出 DEBUG，INFO，WARNING，ERROR 和 FATAL 级别的 Log
  Debug,
  // 输出 INFO，WARNING，ERROR 和 FATAL 级别的 Log
  Info,
  // 输出 WARNING，ERROR 和 FATAL 级别的 Log
  Warn,
  // 只输出 ERROR 和 FATAL 级别的 Log
  Error,
  // 只输出 FATAL 级别的 Log
  Fatal,
  // 不输出任何 SDK Log
  Null,
}

class LogLevelTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(LogLevelEnum value) => value.index;

  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static LogLevelEnum getByInt(int index) => LogLevelEnum.values[index];
}
