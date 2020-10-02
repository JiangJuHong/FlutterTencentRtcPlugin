/// 应用场景枚举
enum SceneEnum {
  // 视频通话
  VideoCall,
  // 直播
  Live,
  // 语音通话
  AudioCall,
  // 语音聊天室
  VoiceChatRoom,
}

/// 应用场景工具类
class SceneTool {
  /// 转换为常量类型
  /// [scene] 应用场景枚举
  /// [Return] 转换结果
  static int toInt(SceneEnum scene) => scene.index;
}
