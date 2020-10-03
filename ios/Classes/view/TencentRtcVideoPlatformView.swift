import TXLiteAVSDK_TRTC
import Flutter

//  Created by 蒋具宏 on 2020/2/21.
//  视频视图工厂
public class TencentRtcVideoPlatformViewFactory : NSObject,FlutterPlatformViewFactory{
    /**
     * 全局标识
     */
    public static let SIGN = "plugins.huic.top/tencentRtcVideoView";
    
    /**
     *   消息器
     */
    private var message : FlutterBinaryMessenger;
    
    
    init(message : FlutterBinaryMessenger) {
        self.message = message;
    }
    
    /**
     *  视图创建
     */
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        
        let view = TencentRtcVideoPlatformView(frame);
        
        // 绑定方法监听
        FlutterMethodChannel(
            name: "\(TencentRtcVideoPlatformViewFactory.SIGN)_\(viewId)",
            binaryMessenger: message
        ).setMethodCallHandler(view.handle);
        
        return view;
    }
}

// 视频视图
public class TencentRtcVideoPlatformView : NSObject,FlutterPlatformView{
    /**
     * 远程视图
     */
    private var remoteView : TRTCVideoView;
    
    /**
     *  窗体
     */
    private var frame : CGRect;
    
    init(_ frame : CGRect) {
        self.frame = frame;
        self.remoteView = TRTCVideoView();
    }
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startRemoteView":
            self.startRemoteView(call: call, result: result);
            break;
        case "startLocalPreview":
            self.startLocalPreview(call: call, result: result);
            break;
        case "startRemoteSubStreamView":
            self.startRemoteSubStreamView(call: call, result: result);
            break;
        default:
            result(FlutterMethodNotImplemented);
        }
    }
    
    /**
     *  视图对象
     */
    public func view() -> UIView {
        return remoteView;
    }
    
    /**
     * 开启远程显示
     */
    public func startRemoteView(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String{
            TRTCCloud.sharedInstance()?.startRemoteView(userId, view: self.remoteView);
            result(nil);
        }
    }
    
    /**
     * 开启本地视频采集
     */
    public func startLocalPreview(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let frontCamera = CommonUtils.getParam(call: call, result: result, param: "frontCamera") as? Bool{
            TRTCCloud.sharedInstance()?.startLocalPreview(frontCamera, view: self.remoteView);
            result(nil);
        }
    }

    /**
     * 开启远端辅流显示
     */
    public func startRemoteSubStreamView(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String{
            TRTCCloud.sharedInstance()?.startRemoteSubStreamView(userId, view: self.remoteView);
            result(nil);
        }
    }
}
