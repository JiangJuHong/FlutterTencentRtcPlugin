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
     * 加入房间
     */
    EnterRoom,
    /**
     * 退出房间
     */
    ExitRoom,
    /**
     * 由用户上行视频数据
     */
    UserVideoAvailable,
}
