package top.huic.tencent_rtc_plugin.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.ValueFilter;

import java.util.List;
import java.util.Map;

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
     * 将对象转换为Map
     *
     * @param data 对象
     * @return 解析结果
     */
    public static Map<String,Object> toMap(Object data) {
        return JSON.parseObject(JSON.toJSONString(data),Map.class);
    }

    /**
     * 将对象转换为Map数组
     *
     * @param data 对象
     * @return 解析结果
     */
    public static List<Map> toMapArray(Object data) {
        return JSON.parseArray(JSON.toJSONString(data),Map.class);
    }
}
