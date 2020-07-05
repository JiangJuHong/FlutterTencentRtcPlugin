package top.huic.tencent_rtc_plugin.listener;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.tencent.trtc.TRTCCloudDef;
import com.tencent.trtc.TRTCCloudListener;
import com.tencent.trtc.TRTCStatistics;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_rtc_plugin.enums.CallBackNoticeEnum;
import top.huic.tencent_rtc_plugin.util.JsonUtil;

/**
 * 腾讯云音视频通信监听器
 */
public class CustomTRTCCloudListener extends TRTCCloudListener {

    private final static String TAG = CustomTRTCCloudListener.class.getName();

    /**
     * 监听器回调的方法名
     */
    private final static String LISTENER_FUNC_NAME = "onListener";

    /**
     * 与Flutter的通信管道
     */
    private MethodChannel channel;

    public CustomTRTCCloudListener(MethodChannel channel) {
        this.channel = channel;
    }

    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    private void invokeListener(CallBackNoticeEnum type, Object params) {
        Map<String, Object> resultParams = new HashMap<>(2, 1);
        resultParams.put("type", type);
        if (params != null) {
            // 字符串单独解析，否则会有双引号
            if (params instanceof String) {
                resultParams.put("params", params);
            } else {
                resultParams.put("params", JsonUtil.toJSONString(params));
            }
        }
        channel.invokeMethod(LISTENER_FUNC_NAME, JsonUtil.toJSONString(resultParams));
    }

    /**
     * SDK加载错误回调 错误通知是要监听的，错误通知意味着 SDK 不能继续运行了
     */
    @Override
    public void onError(int errCode, String errMsg, Bundle extraInfo) {
        super.onError(errCode, errMsg, extraInfo);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("code", errCode);
        params.put("msg", errMsg);
        this.invokeListener(CallBackNoticeEnum.SdkError, params);
    }

    /**
     * 警告回调，用于告知您一些非严重性问题，例如出现卡顿或者可恢复的解码失败。
     */
    @Override
    public void onWarning(int i, String s, Bundle bundle) {
        super.onWarning(i, s, bundle);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("code", i);
        params.put("msg", s);
        this.invokeListener(CallBackNoticeEnum.Warning, params);
    }

    /**
     * 加入房间监听器
     */
    @Override
    public void onEnterRoom(long l) {
        super.onEnterRoom(l);
        this.invokeListener(CallBackNoticeEnum.EnterRoom, l);
    }

    /**
     * 退出房间监听器
     */
    @Override
    public void onExitRoom(int i) {
        super.onExitRoom(i);
        this.invokeListener(CallBackNoticeEnum.ExitRoom, i);
    }

    /**
     * 切换角色
     */
    @Override
    public void onSwitchRole(int i, String s) {
        super.onSwitchRole(i, s);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("code", i);
        params.put("msg", s);
        this.invokeListener(CallBackNoticeEnum.SwitchRole, params);
    }

    /**
     * 请求跨房通话（主播 PK）的结果回调。
     */
    @Override
    public void onConnectOtherRoom(String s, int i, String s1) {
        super.onConnectOtherRoom(s, i, s1);
        Map<String, Object> params = new HashMap<>(3, 1);
        params.put("userId", s);
        params.put("code", i);
        params.put("msg", s1);
        this.invokeListener(CallBackNoticeEnum.ConnectOtherRoom, params);
    }

    /**
     * 结束跨房通话（主播 PK）的结果回调。
     */
    @Override
    public void onDisConnectOtherRoom(int i, String s) {
        super.onDisConnectOtherRoom(i, s);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("code", i);
        params.put("msg", s);
        this.invokeListener(CallBackNoticeEnum.DisConnectOtherRoom, params);
    }

    /**
     * 有用户加入当前房间。
     */
    @Override
    public void onRemoteUserEnterRoom(String s) {
        super.onRemoteUserEnterRoom(s);
        this.invokeListener(CallBackNoticeEnum.RemoteUserEnterRoom, s);
    }

    /**
     * 有用户离开当前房间。
     */
    @Override
    public void onRemoteUserLeaveRoom(String s, int i) {
        super.onRemoteUserLeaveRoom(s, i);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("userId", s);
        params.put("reason", i);
        this.invokeListener(CallBackNoticeEnum.RemoteUserLeaveRoom, params);
    }

    /**
     * 有用户上传视频数据
     */
    @Override
    public void onUserVideoAvailable(String userId, boolean available) {
        super.onUserVideoAvailable(userId, available);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("userId", userId);
        params.put("available", available);
        this.invokeListener(CallBackNoticeEnum.UserVideoAvailable, params);
    }

    /**
     * 有用户上传屏幕数据
     */
    @Override
    public void onUserSubStreamAvailable(String userId, boolean available) {
        super.onUserSubStreamAvailable(userId, available);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("userId", userId);
        params.put("available", available);
        this.invokeListener(CallBackNoticeEnum.UserSubStreamAvailable, params);
    }

    /**
     * 有用户上传音频数据
     */
    @Override
    public void onUserAudioAvailable(String userId, boolean available) {
        super.onUserAudioAvailable(userId, available);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("userId", userId);
        params.put("available", available);
        this.invokeListener(CallBackNoticeEnum.UserAudioAvailable, params);
    }

    /**
     * 开始渲染本地或远程用户的首帧画面。
     */
    @Override
    public void onFirstVideoFrame(String userId, int i, int i1, int i2) {
        super.onFirstVideoFrame(userId, i, i1, i2);
        Map<String, Object> params = new HashMap<>(4, 1);
        params.put("userId", userId);
        params.put("streamType", i);
        params.put("width", i1);
        params.put("height", i2);
        this.invokeListener(CallBackNoticeEnum.FirstVideoFrame, params);
    }

    /**
     * 开始播放远程用户的首帧音频（本地声音暂不通知）。
     */
    @Override
    public void onFirstAudioFrame(String s) {
        super.onFirstAudioFrame(s);
        this.invokeListener(CallBackNoticeEnum.FirstAudioFrame, s);
    }

    /**
     * 首帧本地视频数据已经被送出。
     */
    @Override
    public void onSendFirstLocalVideoFrame(int i) {
        super.onSendFirstLocalVideoFrame(i);
        this.invokeListener(CallBackNoticeEnum.SendFirstLocalVideoFrame, i);
    }

    /**
     * 首帧本地音频数据已经被送出。
     */
    @Override
    public void onSendFirstLocalAudioFrame() {
        super.onSendFirstLocalAudioFrame();
        this.invokeListener(CallBackNoticeEnum.SendFirstLocalAudioFrame, null);
    }

    /**
     * 网络质量：该回调每2秒触发一次，统计当前网络的上行和下行质量。
     */
    @Override
    public void onNetworkQuality(TRTCCloudDef.TRTCQuality trtcQuality, ArrayList<TRTCCloudDef.TRTCQuality> arrayList) {
        super.onNetworkQuality(trtcQuality, arrayList);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("localQuality", trtcQuality);
        params.put("remoteQuality", arrayList);
        this.invokeListener(CallBackNoticeEnum.NetworkQuality, params);
    }

    /**
     * 技术指标统计回调:。
     */
    @Override
    public void onStatistics(TRTCStatistics trtcStatistics) {
        super.onStatistics(trtcStatistics);
        this.invokeListener(CallBackNoticeEnum.Statistics, trtcStatistics);
    }

    /**
     * 跟服务器断开
     */
    @Override
    public void onConnectionLost() {
        super.onConnectionLost();
        this.invokeListener(CallBackNoticeEnum.ConnectionLost, null);
    }

    /**
     * SDK 尝试重新连接到服务器。
     */
    @Override
    public void onTryToReconnect() {
        super.onTryToReconnect();
        this.invokeListener(CallBackNoticeEnum.TryToReconnect, null);
    }

    /**
     * SDK 跟服务器的连接恢复。
     */
    @Override
    public void onConnectionRecovery() {
        super.onConnectionRecovery();
        this.invokeListener(CallBackNoticeEnum.ConnectionRecovery, null);
    }

    /**
     * 服务器测速的回调，SDK 对多个服务器 IP 做测速，每个 IP 的测速结果通过这个回调通知。【仅Android】
     */
    @Override
    public void onSpeedTest(TRTCCloudDef.TRTCSpeedTestResult trtcSpeedTestResult, int i, int i1) {
        super.onSpeedTest(trtcSpeedTestResult, i, i1);
        Map<String, Object> params = new HashMap<>(3, 1);
        params.put("currentResult", trtcSpeedTestResult);
        params.put("finishedCount", i);
        params.put("totalCount", i1);
        this.invokeListener(CallBackNoticeEnum.SpeedTest, params);
    }

    /**
     * 摄像头准备就绪。
     */
    @Override
    public void onCameraDidReady() {
        super.onCameraDidReady();
        this.invokeListener(CallBackNoticeEnum.CameraDidReady, null);
    }

    /**
     * 麦克风准备就绪。
     */
    @Override
    public void onMicDidReady() {
        super.onMicDidReady();
        this.invokeListener(CallBackNoticeEnum.MicDidReady, null);
    }

    /**
     * 音频路由发生变化，音频路由即声音由哪里输出（扬声器、听筒）。
     */
    @Override
    public void onAudioRouteChanged(int i, int i1) {
        super.onAudioRouteChanged(i, i1);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("newRoute", i);
        params.put("oldRoute", i1);
        this.invokeListener(CallBackNoticeEnum.AudioRouteChanged, params);
    }

    /**
     * 用于提示音量大小的回调，包括每个 userId 的音量和远端总音量。
     */
    @Override
    public void onUserVoiceVolume(ArrayList<TRTCCloudDef.TRTCVolumeInfo> arrayList, int i) {
        super.onUserVoiceVolume(arrayList, i);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("userVolumes", arrayList);
        params.put("totalVolume", i);
        this.invokeListener(CallBackNoticeEnum.UserVoiceVolume, params);
    }

    /**
     * 收到自定义消息
     */
    @Override
    public void onRecvCustomCmdMsg(String s, int i, int i1, byte[] bytes) {
        super.onRecvCustomCmdMsg(s, i, i1, bytes);
        Map<String, Object> params = new HashMap<>(4, 1);
        params.put("userId", s);
        params.put("cmdID", i);
        params.put("seq", i1);
        params.put("message", bytes);
        this.invokeListener(CallBackNoticeEnum.RecvCustomCmdMsg, params);
    }

    /**
     * 自定义消息丢失
     */
    @Override
    public void onMissCustomCmdMsg(String s, int i, int i1, int i2) {
        super.onMissCustomCmdMsg(s, i, i1, i2);
        Map<String, Object> params = new HashMap<>(4, 1);
        params.put("userId", s);
        params.put("cmdID", i);
        params.put("errCode", i1);
        params.put("missed", i2);
        this.invokeListener(CallBackNoticeEnum.MissCustomCmdMsg, params);
    }

    /**
     * 收到SEI消息
     */
    @Override
    public void onRecvSEIMsg(String s, byte[] bytes) {
        super.onRecvSEIMsg(s, bytes);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("userId", s);
        params.put("data", bytes);
        this.invokeListener(CallBackNoticeEnum.RecvSEIMsg, params);
    }

    /**
     * 启动旁路推流到 CDN 完成的回调。
     */
    @Override
    public void onStartPublishCDNStream(int i, String s) {
        super.onStartPublishCDNStream(i, s);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("err", i);
        params.put("errMsg", s);
        this.invokeListener(CallBackNoticeEnum.StartPublishCDNStream, params);
    }

    /**
     * 停止旁路推流到 CDN 完成的回调。
     */
    @Override
    public void onStopPublishCDNStream(int i, String s) {
        super.onStopPublishCDNStream(i, s);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("err", i);
        params.put("errMsg", s);
        this.invokeListener(CallBackNoticeEnum.StopPublishCDNStream, params);
    }

    /**
     * 设置云端的混流转码参数的回调，对应于 TRTCCloud 中的 setMixTranscodingConfig() 接口。
     */
    @Override
    public void onSetMixTranscodingConfig(int i, String s) {
        super.onSetMixTranscodingConfig(i, s);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("err", i);
        params.put("errMsg", s);
        this.invokeListener(CallBackNoticeEnum.SetMixTranscodingConfig, params);
    }

    /**
     * 播放音效结束回调。
     */
    @Override
    public void onAudioEffectFinished(int i, int i1) {
        super.onAudioEffectFinished(i, i1);
        Map<String, Object> params = new HashMap<>(2, 1);
        params.put("effectId", i);
        params.put("code", i1);
        this.invokeListener(CallBackNoticeEnum.AudioEffectFinished, params);
    }
}