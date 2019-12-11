package top.huic.tencent_rtc_plugin.listener;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.tencent.trtc.TRTCCloudListener;

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
}