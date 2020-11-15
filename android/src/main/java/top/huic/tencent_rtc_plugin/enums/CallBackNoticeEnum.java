package top.huic.tencent_rtc_plugin.enums;

/**
 * 回调通知枚举
 *
 * @author 蒋具宏
 */
public enum CallBackNoticeEnum {
    /**
     * SDK加载错误
     */
    SdkError,
    /**
     * 警告，例如出现卡顿或者可恢复的解码失败。
     */
    Warning,
    /**
     * 加入房间
     */
    EnterRoom,
    /**
     * 退出房间
     */
    ExitRoom,
    /**
     * 切换角色
     */
    SwitchRole,
    /**
     * 请求跨房通话（主播 PK）的结果回调。
     */
    ConnectOtherRoom,
    /**
     * 结束跨房通话（主播 PK）的结果回调。
     */
    DisConnectOtherRoom,
    /**
     * 有用户加入当前房间。
     */
    RemoteUserEnterRoom,
    /**
     * 有用户离开当前房间。
     */
    RemoteUserLeaveRoom,
    /**
     * 用户是否上行视频数据
     */
    UserVideoAvailable,
    /**
     * 用户是否上行屏幕数据
     */
    UserSubStreamAvailable,
    /**
     * 用户是否上行音频数据
     */
    UserAudioAvailable,
    /**
     * 开始渲染本地或远程用户的首帧画面。
     */
    FirstVideoFrame,
    /**
     * 开始播放远程用户的首帧音频（本地声音暂不通知）。
     */
    FirstAudioFrame,
    /**
     * 首帧本地音频数据已经被送出。
     */
    SendFirstLocalAudioFrame,
    /**
     * 首帧本地视频数据已经被送出。
     */
    SendFirstLocalVideoFrame,
    /**
     * 网络质量：该回调每2秒触发一次，统计当前网络的上行和下行质量。
     */
    NetworkQuality,
    /**
     * 技术指标统计回调:。
     */
    Statistics,
    /**
     * 跟服务器断开
     */
    ConnectionLost,
    /**
     * SDK 尝试重新连接到服务器。
     */
    TryToReconnect,
    /**
     * SDK 跟服务器的连接恢复。
     */
    ConnectionRecovery,
    /**
     * 服务器测速的回调，SDK 对多个服务器 IP 做测速，每个 IP 的测速结果通过这个回调通知。
     */
    SpeedTest,
    /**
     * 摄像头准备就绪。
     */
    CameraDidReady,
    /**
     * 麦克风准备就绪
     */
    MicDidReady,
    /**
     * 音频路由发生变化，音频路由即声音由哪里输出（扬声器、听筒）。
     */
    AudioRouteChanged,
    /**
     * 用于提示音量大小的回调，包括每个 userId 的音量和远端总音量。
     */
    UserVoiceVolume,
    /**
     * 收到自定义消息
     */
    RecvCustomCmdMsg,
    /**
     * 自定义消息丢失
     */
    MissCustomCmdMsg,
    /**
     * 收到SEI消息
     */
    RecvSEIMsg,
    /**
     * 开始向腾讯云的直播 CDN 推流的回调
     */
    StartPublishing,
    /**
     * 停止向腾讯云的直播 CDN 推流的回调
     */
    StopPublishing,
    /**
     * 启动旁路推流到 CDN 完成的回调。
     */
    StartPublishCDNStream,
    /**
     * 停止旁路推流到 CDN 完成的回调。
     */
    StopPublishCDNStream,
    /**
     * 设置云端的混流转码参数的回调，对应于 TRTCCloud 中的 setMixTranscodingConfig() 接口。
     */
    SetMixTranscodingConfig,
    /**
     * 播放音效结束回调。
     */
    AudioEffectFinished,
    /**
     * 屏幕分享开始回调
     */
    ScreenCaptureStarted,
    /**
     * 屏幕分享暂停回调
     */
    ScreenCapturePaused,
    /**
     * 屏幕分享恢复回调
     */
    ScreenCaptureResumed,
    /**
     * 屏幕分享停止回调
     */
    ScreenCaptureStopped,
    /**
     * 本地麦克风采集到的音频数据回调
     */
    CapturedRawAudioFrame,
    /**
     * 本地采集并经过音频模块前处理后的音频数据回调
     */
    LocalProcessedAudioFrame,
    /**
     * 混音前的每一路远程用户的音频数据，即混音前的各路原始数据。例如，对某一路音频进行文字转换时，您必须使用该路音频的原始数据
     */
    RemoteUserAudioFrame,
    /**
     * 各路音频数据混合后送入喇叭播放的音频数据
     */
    MixedPlayAudioFrame,
    /**
     * 日志
     */
    Log,
}
