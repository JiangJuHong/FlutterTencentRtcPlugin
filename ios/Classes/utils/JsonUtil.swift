import Foundation

//  Json工具类
//  Created by 蒋具宏 on 2020/2/11.
public class JsonUtil {
    /**
     * 将json字符串转换为字典
     */
    public static func getDictionaryFromJSONString(jsonString: String) -> [String: Any] {

        let jsonData: Data = jsonString.data(using: .utf8)!

        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return (dict as! NSDictionary) as! [String: Any]
        }
        return NSDictionary() as! [String: Any]
    }
}
