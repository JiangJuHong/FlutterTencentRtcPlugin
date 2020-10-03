/// 重力感应枚举
enum SystemVolumeTypeEnum {
  // “麦上通话，麦下媒体”，即主播上麦时使用通话音量，观众不上麦则使用媒体音量，适合在线直播场景。
  // 如果您在 enterRoom 时选择的场景为 TRTC_APP_SCENE_LIVE 或 TRTC_APP_SCENE_VOICE_CHATROOM，SDK 会自动选择该模式。
  Auto,
  // 通话全程使用媒体音量，不常用，适合个别有特殊需求（如主播外接声卡）的应用场景。
  Media,
  // 全程使用通话音量，适合多人会议场景。
  // 如果您在 enterRoom 时选择的场景为 TRTC_APP_SCENE_VIDEOCALL 或 TRTC_APP_SCENE_AUDIOCALL，SDK 会自动选择该模式。
  VOIP,
}

class SystemVolumeTypeTool {
  /// 转换为常量类型
  /// [value] 枚举
  /// [Return] 转换结果
  static int toInt(SystemVolumeTypeEnum value) => value.index;
}
