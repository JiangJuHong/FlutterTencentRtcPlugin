package top.huic.tencent_rtc_plugin.listener;

import android.os.Handler;
import android.os.Looper;

import com.tencent.trtc.TRTCCloudDef;
import com.tencent.trtc.TRTCCloudListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_rtc_plugin.enums.CallBackNoticeEnum;
import top.huic.tencent_rtc_plugin.util.ListenerUtil;

/**
 * 自定义音频相关监听器
 */
public class CustomTRTCAudioFrameListener implements TRTCCloudListener.TRTCAudioFrameListener {
    /**
     * 与Flutter的通信管道
     */
    private final MethodChannel channel;

    /**
     * 主线程处理器
     */
    private final static Handler MAIN_HANDLER = new Handler(Looper.getMainLooper());


    public CustomTRTCAudioFrameListener(MethodChannel channel) {
        this.channel = channel;
    }

    /**
     * 本地麦克风采集到的音频数据回调
     */
    @Override
    public void onCapturedRawAudioFrame(TRTCCloudDef.TRTCAudioFrame trtcAudioFrame) {
        final Map<String, Object> params = new HashMap<>(4, 1);
        params.put("data", trtcAudioFrame.data);
        params.put("sampleRate", trtcAudioFrame.sampleRate);
        params.put("channel", trtcAudioFrame.channel);
        params.put("timestamp", trtcAudioFrame.timestamp);
        MAIN_HANDLER.post(new Runnable() {
            @Override
            public void run() {
                ListenerUtil.invokeListener(channel, CallBackNoticeEnum.CapturedRawAudioFrame, params);
            }
        });
    }

    /**
     * 本地采集并经过音频模块前处理后的音频数据回调
     */
    @Override
    public void onLocalProcessedAudioFrame(TRTCCloudDef.TRTCAudioFrame trtcAudioFrame) {
        final Map<String, Object> params = new HashMap<>(4, 1);
        params.put("data", trtcAudioFrame.data);
        params.put("sampleRate", trtcAudioFrame.sampleRate);
        params.put("channel", trtcAudioFrame.channel);
        params.put("timestamp", trtcAudioFrame.timestamp);
        MAIN_HANDLER.post(new Runnable() {
            @Override
            public void run() {
                ListenerUtil.invokeListener(channel, CallBackNoticeEnum.LocalProcessedAudioFrame, params);
            }
        });
    }

    /**
     * 混音前的每一路远程用户的音频数据，即混音前的各路原始数据。例如，对某一路音频进行文字转换时，您必须使用该路音频的原始数据
     */
    @Override
    public void onRemoteUserAudioFrame(TRTCCloudDef.TRTCAudioFrame trtcAudioFrame, String s) {
        final Map<String, Object> params = new HashMap<>(5, 1);
        params.put("userId", s);
        params.put("data", trtcAudioFrame.data);
        params.put("sampleRate", trtcAudioFrame.sampleRate);
        params.put("channel", trtcAudioFrame.channel);
        params.put("timestamp", trtcAudioFrame.timestamp);
        MAIN_HANDLER.post(new Runnable() {
            @Override
            public void run() {
                ListenerUtil.invokeListener(channel, CallBackNoticeEnum.RemoteUserAudioFrame, params);
            }
        });
    }

    /**
     * 各路音频数据混合后送入喇叭播放的音频数据
     */
    @Override
    public void onMixedPlayAudioFrame(TRTCCloudDef.TRTCAudioFrame trtcAudioFrame) {
        final Map<String, Object> params = new HashMap<>(4, 1);
        params.put("data", trtcAudioFrame.data);
        params.put("sampleRate", trtcAudioFrame.sampleRate);
        params.put("channel", trtcAudioFrame.channel);
        params.put("timestamp", trtcAudioFrame.timestamp);
        MAIN_HANDLER.post(new Runnable() {
            @Override
            public void run() {
                ListenerUtil.invokeListener(channel, CallBackNoticeEnum.MixedPlayAudioFrame, params);
            }
        });
    }
}
