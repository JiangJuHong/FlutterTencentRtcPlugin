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
     * 全局上下文
     */
    private Context context;

    /**
     * 与Flutter的通信管道
     */
    private MethodChannel channel;

    public CustomTRTCCloudListener(Context context, MethodChannel channel) {
        this.context = context;
        this.channel = channel;
    }

    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    private void invokeListener(CallBackNoticeEnum type, Object params) {
        Log.d(TAG, "invokeListener: 触发监听:" + type + "[" + params + "]");
        Map<String, Object> resultParams = new HashMap<>(2, 1);
        resultParams.put("type", type);
        resultParams.put("params", params == null ? null : JSON.toJSONString(params));
        channel.invokeMethod(LISTENER_FUNC_NAME, JSON.toJSONString(resultParams));
    }

    /**
     * SDK加载错误回调
     * 错误通知是要监听的，错误通知意味着 SDK 不能继续运行了
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

    @Override
    public void onWarning(int i, String s, Bundle bundle) {
        super.onWarning(i, s, bundle);
    }

    @Override
    public void onSwitchRole(int i, String s) {
        super.onSwitchRole(i, s);
    }

    @Override
    public void onConnectOtherRoom(String s, int i, String s1) {
        super.onConnectOtherRoom(s, i, s1);
    }

    @Override
    public void onDisConnectOtherRoom(int i, String s) {
        super.onDisConnectOtherRoom(i, s);
    }

    @Override
    public void onRemoteUserEnterRoom(String s) {
        super.onRemoteUserEnterRoom(s);
    }

    @Override
    public void onRemoteUserLeaveRoom(String s, int i) {
        super.onRemoteUserLeaveRoom(s, i);
    }

    @Override
    public void onUserSubStreamAvailable(String s, boolean b) {
        super.onUserSubStreamAvailable(s, b);
    }

    @Override
    public void onUserAudioAvailable(String s, boolean b) {
        super.onUserAudioAvailable(s, b);
    }

    @Override
    public void onFirstVideoFrame(String s, int i, int i1, int i2) {
        super.onFirstVideoFrame(s, i, i1, i2);
    }

    @Override
    public void onFirstAudioFrame(String s) {
        super.onFirstAudioFrame(s);
    }

    @Override
    public void onSendFirstLocalVideoFrame(int i) {
        super.onSendFirstLocalVideoFrame(i);
    }

    @Override
    public void onSendFirstLocalAudioFrame() {
        super.onSendFirstLocalAudioFrame();
    }

    @Override
    public void onUserEnter(String s) {
        super.onUserEnter(s);
    }

    @Override
    public void onUserExit(String s, int i) {
        super.onUserExit(s, i);
    }

    @Override
    public void onNetworkQuality(TRTCCloudDef.TRTCQuality trtcQuality, ArrayList<TRTCCloudDef.TRTCQuality> arrayList) {
        super.onNetworkQuality(trtcQuality, arrayList);
    }

    @Override
    public void onStatistics(TRTCStatistics trtcStatistics) {
        super.onStatistics(trtcStatistics);
    }

    @Override
    public void onConnectionLost() {
        super.onConnectionLost();
    }

    @Override
    public void onTryToReconnect() {
        super.onTryToReconnect();
    }

    @Override
    public void onConnectionRecovery() {
        super.onConnectionRecovery();
    }

    @Override
    public void onSpeedTest(TRTCCloudDef.TRTCSpeedTestResult trtcSpeedTestResult, int i, int i1) {
        super.onSpeedTest(trtcSpeedTestResult, i, i1);
    }

    @Override
    public void onCameraDidReady() {
        super.onCameraDidReady();
    }

    @Override
    public void onMicDidReady() {
        super.onMicDidReady();
    }

    @Override
    public void onAudioRouteChanged(int i, int i1) {
        super.onAudioRouteChanged(i, i1);
    }

    @Override
    public void onUserVoiceVolume(ArrayList<TRTCCloudDef.TRTCVolumeInfo> arrayList, int i) {
        super.onUserVoiceVolume(arrayList, i);
    }

    @Override
    public void onRecvCustomCmdMsg(String s, int i, int i1, byte[] bytes) {
        super.onRecvCustomCmdMsg(s, i, i1, bytes);
    }

    @Override
    public void onMissCustomCmdMsg(String s, int i, int i1, int i2) {
        super.onMissCustomCmdMsg(s, i, i1, i2);
    }

    @Override
    public void onRecvSEIMsg(String s, byte[] bytes) {
        super.onRecvSEIMsg(s, bytes);
    }

    @Override
    public void onStartPublishCDNStream(int i, String s) {
        super.onStartPublishCDNStream(i, s);
    }

    @Override
    public void onStopPublishCDNStream(int i, String s) {
        super.onStopPublishCDNStream(i, s);
    }

    @Override
    public void onSetMixTranscodingConfig(int i, String s) {
        super.onSetMixTranscodingConfig(i, s);
    }

    @Override
    public void onAudioEffectFinished(int i, int i1) {
        super.onAudioEffectFinished(i, i1);
    }
}