package top.huic.tencent_rtc_plugin.listener;

import com.tencent.trtc.TRTCCloudListener;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_rtc_plugin.enums.CallBackNoticeEnum;
import top.huic.tencent_rtc_plugin.util.ListenerUtil;

/**
 * 自定义日志监听器
 *
 * @author 蒋具宏
 */
public class CustomTRTCLogListener extends TRTCCloudListener.TRTCLogListener {

    /**
     * 与Flutter的通信管道
     */
    private MethodChannel channel;

    public CustomTRTCLogListener(MethodChannel channel) {
        this.channel = channel;
    }


    @Override
    public void onLog(String log, int level, String module) {
        Map<String, Object> params = new HashMap<>(3, 1);
        params.put("log", log);
        params.put("level", level);
        params.put("module", module);
        ListenerUtil.invokeListener(channel, CallBackNoticeEnum.Log, params);
    }
}
