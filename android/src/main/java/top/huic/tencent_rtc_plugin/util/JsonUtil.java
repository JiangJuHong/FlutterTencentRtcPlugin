package top.huic.tencent_rtc_plugin.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.ValueFilter;

/**
 * JSON工具类
 *
 * @author 蒋具宏
 */
public class JsonUtil {
    /**
     * 自定义数据过滤穷
     */
    private static final ValueFilter filter = new ValueFilter() {
        @Override
        public Object process(Object object, String name, Object value) {
            if (value instanceof byte[]) {
                return new String((byte[]) value);
            }
            return value;
        }
    };

    /**
     * 将对象序列化为JSON
     *
     * @param data 对象
     * @return 解析结果
     */
    public static String toJSONString(Object data) {
        return JsonUtil.toJSONString(data, filter);
    }
}
