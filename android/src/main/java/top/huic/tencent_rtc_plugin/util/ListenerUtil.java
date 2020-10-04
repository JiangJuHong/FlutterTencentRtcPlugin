package top.huic.tencent_rtc_plugin.util;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_rtc_plugin.enums.CallBackNoticeEnum;

/**
 * 监听器工具类
 *
 * @author 蒋具宏
 */
public class ListenerUtil {

    /**
     * 监听器回调的方法名
     */
    private final static String LISTENER_FUNC_NAME = "onListener";

    /**
     * 调用监听器
     *
     * @param channel 方法调用器
     * @param type    类型
     * @param params  参数
     */
    public static void invokeListener(MethodChannel channel, CallBackNoticeEnum type, Object params) {
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
}
