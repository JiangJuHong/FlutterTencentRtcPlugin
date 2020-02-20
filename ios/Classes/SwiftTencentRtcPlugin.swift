import Flutter
import UIKit
import TXLiteAVSDK_TRTC

public class SwiftTencentRtcPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tencent_rtc_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftTencentRtcPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//        switch call.method {
//        case "enterRoom":
//            self.enterRoom(call: call, result: result)
//            break
//        default:
//            result(FlutterMethodNotImplemented);
//        }
    }
}
