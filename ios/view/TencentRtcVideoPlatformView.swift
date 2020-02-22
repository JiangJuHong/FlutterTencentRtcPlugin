import TXLiteAVSDK_TRTC

//  Created by 蒋具宏 on 2020/2/21.
//  视频视图
public class TencentRtcVideoPlatformView : NSObject,FlutterPlatformViewFactory,FlutterPlatformView{
    /**
     * 全局标识
     */
    public static let SIGN = "plugins.huic.top/tencentRtcVideoView";
    
    /**
     *   消息器
     */
    private var message : FlutterBinaryMessenger?;
    
    /**
     * 远程视图
     */
//    private var remoteView : TRTCVideoView;
    
    init(message : FlutterBinaryMessenger) {
        super.init();
        self.message = message;
    }
    
    /**
     *  视图创建
     */
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let view = TencentRtcVideoPlatformView(message: message!);
        
        let methodChannel = FlutterMethodChannel(name: "\(TencentRtcVideoPlatformView.SIGN)_\(viewId)", binaryMessenger: message!);
        methodChannel.setMethodCallHandler(handle);
        return view;
    }
    
    /**
     *  方法处理器
     */
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     *  视图对象
     */
    public func view() -> UIView {
        let view = UIView(frame:CGRect(x:40,y:80,width:240,height:240))
        view.backgroundColor = UIColor.black
        return view;
    }
}
