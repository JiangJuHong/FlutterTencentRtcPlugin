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
        invokeListener(channel, type, params, true);
    }

    /**
     * 调用监听器
     *
     * @param channel 方法调用器
     * @param type    类型
     * @param params  参数
     * @param cover   是否对json进行转换
     */
    public static void invokeListener(MethodChannel channel, CallBackNoticeEnum type, Object params, boolean cover) {
        Map<String, Object> resultParams = new HashMap<>(2, 1);
        resultParams.put("type", type.toString());
        if (params != null) {
            // 1. 字符串不进行json解析，否则会有双引号
            // 2. cover 为false时不进行json转换
            if (params instanceof String || !cover) {
                resultParams.put("params", params);
            } else {
                resultParams.put("params", JsonUtil.toJSONString(params));
            }
        }
        channel.invokeMethod(LISTENER_FUNC_NAME, cover ? JsonUtil.toJSONString(resultParams) : resultParams);
    }
}
