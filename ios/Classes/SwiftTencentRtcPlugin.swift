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
        switch call.method {
        case "enterRoom":
            self.enterRoom(call: call, result: result);
            break;
        case "exitRoom":
            self.exitRoom(call: call, result: result);
            break;
        case "switchRole":
            self.switchRole(call: call, result: result);
            break;
        case "setDefaultStreamRecvMode":
            self.setDefaultStreamRecvMode(call: call, result: result);
            break;
        case "muteRemoteAudio":
            self.muteRemoteAudio(call: call, result: result);
            break;
        case "muteAllRemoteAudio":
            self.muteAllRemoteAudio(call: call, result: result);
            break;
        case "setRemoteViewFillMode":
            self.setRemoteViewFillMode(call: call, result: result);
            break;
        case "setLocalViewFillMode":
            self.setLocalViewFillMode(call: call, result: result);
            break;
        case "startLocalAudio":
            self.startLocalAudio(call: call, result: result);
            break;
        case "stopLocalAudio":
            self.stopLocalAudio(call: call, result: result);
            break;
        case "stopAllRemoteView":
            self.stopAllRemoteView(call: call, result: result);
            break;
        case "muteRemoteVideoStream":
            self.muteRemoteVideoStream(call: call, result: result);
            break;
        case "muteAllRemoteVideoStreams":
            self.muteAllRemoteVideoStreams(call: call, result: result);
            break;
        case "setVideoEncoderParam":
            self.setVideoEncoderParam(call: call, result: result);
            break;
        case "setNetworkQosParam":
            self.setNetworkQosParam(call: call, result: result);
            break;
        case "setLocalViewRotation":
            self.setLocalViewRotation(call: call, result: result);
            break;
        case "setRemoteViewRotation":
            self.setRemoteViewRotation(call: call, result: result);
            break;
        case "setVideoEncoderRotation":
            self.setVideoEncoderRotation(call: call, result: result);
            break;
        case "setLocalViewMirror":
            self.setLocalViewMirror(call: call, result: result);
            break;
        case "setVideoEncoderMirror":
            self.setVideoEncoderMirror(call: call, result: result);
            break;
        case "setGSensorMode":
            self.setGSensorMode(call: call, result: result);
            break;
        case "enableEncSmallVideoStream":
            self.enableEncSmallVideoStream(call: call, result: result);
            break;
        case "setRemoteVideoStreamType":
            self.setRemoteVideoStreamType(call: call, result: result);
            break;
        case "setPriorRemoteVideoStreamType":
            self.setPriorRemoteVideoStreamType(call: call, result: result);
            break;
        case "muteLocalAudio":
            self.muteLocalAudio(call: call, result: result);
            break;
        case "setAudioRoute":
            self.setAudioRoute(call: call, result: result);
            break;
        case "enableAudioVolumeEvaluation":
            self.enableAudioVolumeEvaluation(call: call, result: result);
            break;
        case "startAudioRecording":
            self.startAudioRecording(call: call, result: result);
            break;
        case "stopAudioRecording":
            self.stopAudioRecording(call: call, result: result);
            break;
        case "setSystemVolumeType":
            self.setSystemVolumeType(call: call, result: result);
            break;
        case "enableAudioEarMonitoring":
            self.enableAudioEarMonitoring(call: call, result: result);
            break;
        case "switchCamera":
            self.switchCamera(call: call, result: result);
            break;
        case "isCameraZoomSupported":
            self.isCameraZoomSupported(call: call, result: result);
            break;
        case "setZoom":
            self.setZoom(call: call, result: result);
            break;
        case "isCameraTorchSupported":
            self.isCameraTorchSupported(call: call, result: result);
            break;
        case "enableTorch":
            self.enableTorch(call: call, result: result);
            break;
        case "isCameraFocusPositionInPreviewSupported":
            self.isCameraFocusPositionInPreviewSupported(call: call, result: result);
            break;
        case "setFocusPosition":
            self.setFocusPosition(call: call, result: result);
            break;
        case "isCameraAutoFocusFaceModeSupported":
            self.isCameraAutoFocusFaceModeSupported(call: call, result: result);
            break;
        default:
            result(FlutterMethodNotImplemented);
        }
    }
    
    /**
     * 进入房间
     */
    public func enterRoom(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let role = ((call.arguments as! [String:Any])["role"]) as? Int;
        if let appid = CommonUtils.getParam(call: call, result: result, param: "appid") as? UInt32,
            let userId = CommonUtils.getParam(call: call, result: result, param: "userId")  as? String,
            let userSig = CommonUtils.getParam(call: call, result: result, param: "userSig")  as? String,
            let roomId = CommonUtils.getParam(call: call, result: result, param: "roomId")  as? UInt32,
            let scene = CommonUtils.getParam(call: call, result: result, param: "scene")  as? Int
        {
            let params = TRTCParams();
            params.sdkAppId = appid;
            params.userId = userId;
            params.userSig = userSig;
            params.roomId = roomId;
            if role != nil{
                params.role = TRTCRoleType(rawValue: role!)!;
            }
            TRTCCloud.sharedInstance()?.enterRoom(params, appScene: TRTCAppScene(rawValue: scene)!);
            result(nil);
        }
    }
    
    /**
     * 退出房间
     */
    public func exitRoom(call: FlutterMethodCall, result: @escaping FlutterResult) {
        TRTCCloud.sharedInstance()?.exitRoom();
        result(nil);
    }
    
    /**
     * 切换角色
     */
    public func switchRole(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let role = CommonUtils.getParam(call: call, result: result, param: "role") as? Int{
            TRTCCloud.sharedInstance()?.switch(TRTCRoleType(rawValue: role)!);
            result(nil);
        }
    }
    
    /**
     * 设置音视频数据接收模式（需要在进房前设置才能生效）。
     */
    public func setDefaultStreamRecvMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let autoRecvAudio = CommonUtils.getParam(call: call, result: result, param: "autoRecvAudio") as? Bool,
            let autoRecvVideo = CommonUtils.getParam(call: call, result: result, param: "autoRecvVideo") as? Bool{
            TRTCCloud.sharedInstance()?.setDefaultStreamRecvMode(autoRecvAudio, video: autoRecvVideo);
            result(nil);
        }
    }
    
    /**
     * 静音 / 取消静音
     */
    public func muteRemoteAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
            let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool{
            TRTCCloud.sharedInstance()?.muteRemoteAudio(userId, mute: mute);
            result(nil);
        }
    }
    
    /**
     * 静音 / 取消静音 所有用户
     */
    public func muteAllRemoteAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool{
            TRTCCloud.sharedInstance()?.muteAllRemoteAudio(mute);
            result(nil);
        }
    }
    
    /**
     * 设置远程显示填充模式
     */
    public func setRemoteViewFillMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
            let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int{
            TRTCCloud.sharedInstance()?.setRemoteViewFillMode(userId, mode: TRTCVideoFillMode(rawValue: mode)!)
            result(nil);
        }
    }
    
    /**
     * 设置本地显示填充模式
     */
    public func setLocalViewFillMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int{
            TRTCCloud.sharedInstance()?.setLocalViewFillMode(TRTCVideoFillMode(rawValue: mode)!)
            result(nil);
        }
    }
    
    /**
     * 开启本地音频采集
     */
    public func startLocalAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        TRTCCloud.sharedInstance()?.startLocalAudio();
        result(nil);
    }
    
    /**
     * 关闭本地音频采集
     */
    public func stopLocalAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        TRTCCloud.sharedInstance()?.stopLocalAudio();
        result(nil);
    }
    
    /**
     * 停止显示所有远端视频画面。
     */
    public func stopAllRemoteView(call: FlutterMethodCall, result: @escaping FlutterResult) {
        TRTCCloud.sharedInstance()?.stopAllRemoteView();
        result(nil);
    }
    
    /**
     * 暂停接收指定的远端视频流。
     */
    public func muteRemoteVideoStream(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
            let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool{
            TRTCCloud.sharedInstance()?.muteRemoteVideoStream(userId, mute: mute);
            result(nil);
        }
    }
    
    /**
     * 停止接收所有远端视频流。
     */
    public func muteAllRemoteVideoStreams(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool{
            TRTCCloud.sharedInstance()?.muteAllRemoteVideoStreams(mute);
            result(nil);
        }
    }
    
    /**
     * 设置视频编码相关。
     */
    public func setVideoEncoderParam(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let param = CommonUtils.getParam(call: call, result: result, param: "param") as? String{
            let dict = JsonUtil.getDictionaryFromJSONString(jsonString: param);
            let data = TRTCVideoEncParam();
            if dict["videoBitrate"] != nil{
                data.videoBitrate = dict["videoBitrate"] as! Int32;
            }
            if dict["videoResolution"] != nil{
                data.videoResolution = TRTCVideoResolution(rawValue: dict["videoResolution"] as! Int)!;
            }
            if dict["videoResolutionMode"] != nil{
                data.resMode = TRTCVideoResolutionMode(rawValue: dict["videoResolutionMode"] as! Int)!;
            }
            if dict["videoFps"] != nil{
                data.videoFps = dict["videoFps"] as! Int32;
            }
            TRTCCloud.sharedInstance()?.setVideoEncoderParam(data);
            result(nil);
        }
    }
    
    /**
     * 设置网络流控相关参数。
     */
    public func setNetworkQosParam(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let preference = CommonUtils.getParam(call: call, result: result, param: "preference") as? Int,
            let controlMode = CommonUtils.getParam(call: call, result: result, param: "controlMode") as? Int{
            let param = TRTCNetworkQosParam();
            param.preference = TRTCVideoQosPreference(rawValue: preference)!;
            param.controlMode = TRTCQosControlMode(rawValue: controlMode)!;
            TRTCCloud.sharedInstance()?.setNetworkQosParam(param);
            result(nil);
        }
    }
    
    /**
     * 设置本地图像的顺时针旋转角度。
     */
    public func setLocalViewRotation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let rotation = CommonUtils.getParam(call: call, result: result, param: "rotation") as? Int{
            TRTCCloud.sharedInstance()?.setLocalViewRotation(TRTCVideoRotation(rawValue: rotation)!);
            result(nil);
        }
    }
    
    /**
     * 设置远端图像的顺时针旋转角度。
     */
    public func setRemoteViewRotation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
            let rotation = CommonUtils.getParam(call: call, result: result, param: "rotation") as? Int{
            TRTCCloud.sharedInstance()?.setRemoteViewRotation(userId, rotation: TRTCVideoRotation(rawValue: rotation)!)
            result(nil);
        }
    }
    
    /**
     * 设置视频编码输出的（也就是远端用户观看到的，以及服务器录制下来的）画面方向。
     */
    public func setVideoEncoderRotation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let rotation = CommonUtils.getParam(call: call, result: result, param: "rotation") as? Int{
            TRTCCloud.sharedInstance()?.setVideoEncoderRotation(TRTCVideoRotation(rawValue: rotation)!);
            result(nil);
        }
    }
    
    /**
     * 设置本地摄像头预览画面的镜像模式。
     */
    public func setLocalViewMirror(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mirrorType = CommonUtils.getParam(call: call, result: result, param: "mirrorType") as? UInt{
            TRTCCloud.sharedInstance()?.setLocalViewMirror(TRTCLocalVideoMirrorType(rawValue: mirrorType)!)
            result(nil);
        }
    }
    
    /**
     * 设置编码器输出的画面镜像模式。
     */
    public func setVideoEncoderMirror(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mirror = CommonUtils.getParam(call: call, result: result, param: "mirror") as? Bool{
            TRTCCloud.sharedInstance()?.setVideoEncoderMirror(mirror);
            result(nil);
        }
    }
    
    /**
     * 设置重力感应的适应模式。
     */
    public func setGSensorMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int{
            TRTCCloud.sharedInstance()?.setGSensorMode(TRTCGSensorMode(rawValue: mode)!);
            result(nil);
        }
    }
    
    /**
     * 开启大小画面双路编码模式。
     */
    public func enableEncSmallVideoStream(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let enable = CommonUtils.getParam(call: call, result: result, param: "enable") as? Bool,
            let smallVideoEncParam = CommonUtils.getParam(call: call, result: result, param: "smallVideoEncParam") as? String{
            let dict = JsonUtil.getDictionaryFromJSONString(jsonString: smallVideoEncParam);
            let data = TRTCVideoEncParam();
            if dict["videoBitrate"] != nil{
                data.videoBitrate = dict["videoBitrate"] as! Int32;
            }
            if dict["videoResolution"] != nil{
                data.videoResolution = TRTCVideoResolution(rawValue: dict["videoResolution"] as! Int)!;
            }
            if dict["videoResolutionMode"] != nil{
                data.resMode = TRTCVideoResolutionMode(rawValue: dict["videoResolutionMode"] as! Int)!;
            }
            if dict["videoFps"] != nil{
                data.videoFps = dict["videoFps"] as! Int32;
            }
            TRTCCloud.sharedInstance()?.enableEncSmallVideoStream(enable, withQuality: data);
            result(nil);
        }
    }
    
    /**
     * 选定观看指定 uid 的大画面或小画面。
     */
    public func setRemoteVideoStreamType(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
            let streamType = CommonUtils.getParam(call: call, result: result, param: "streamType") as? Int{
            TRTCCloud.sharedInstance()?.setRemoteVideoStreamType(userId, type: TRTCVideoStreamType(rawValue: streamType)!);
            result(nil);
        }
    }
    
    /**
     * 设定观看方优先选择的视频质量。
     */
    public func setPriorRemoteVideoStreamType(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let streamType = CommonUtils.getParam(call: call, result: result, param: "streamType") as? Int{
            TRTCCloud.sharedInstance()?.setPriorRemoteVideoStreamType(TRTCVideoStreamType(rawValue: streamType)!);
            result(nil);
        }
    }
    
    /**
     * 静音本地的音频。
     */
    public func muteLocalAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool{
            TRTCCloud.sharedInstance()?.muteLocalAudio(mute);
            result(nil);
        }
    }
    
    /**
     * 设置音频路由。
     */
    public func setAudioRoute(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let route = CommonUtils.getParam(call: call, result: result, param: "route") as? Int{
            TRTCCloud.sharedInstance()?.setAudioRoute(TRTCAudioRoute(rawValue: route)!);
            result(nil);
        }
    }
    
    /**
     * 启用音量大小提示。
     */
    public func enableAudioVolumeEvaluation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let intervalMs = CommonUtils.getParam(call: call, result: result, param: "intervalMs") as? UInt{
            TRTCCloud.sharedInstance()?.enableAudioVolumeEvaluation(intervalMs);
            result(nil);
        }
    }
    
    /**
     * 开始录音。
     */
    public func startAudioRecording(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let filePath = CommonUtils.getParam(call: call, result: result, param: "filePath") as? String{
            let data = TRTCAudioRecordingParams();
            data.filePath = filePath;
            TRTCCloud.sharedInstance()?.startAudioRecording(data);
            result(nil);
        }
    }
    
    /**
     * 停止录音。
     */
    public func stopAudioRecording(call: FlutterMethodCall, result: @escaping FlutterResult) {
        TRTCCloud.sharedInstance()?.stopAudioRecording();
        result(nil);
    }
    
    /**
     * 设置通话时使用的系统音量类型。
     */
    public func setSystemVolumeType(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? Int{
            TRTCCloud.sharedInstance()?.setSystemVolumeType(TRTCSystemVolumeType(rawValue: type)!);
            result(nil);
        }
    }
    
    /**
     * 开启耳返。
     */
    public func enableAudioEarMonitoring(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let enable = CommonUtils.getParam(call: call, result: result, param: "enable") as? Bool{
            TRTCCloud.sharedInstance()?.enableAudioEarMonitoring(enable);
            result(nil);
        }
    }
    
    /**
     * 切换摄像头。
     */
    public func switchCamera(call: FlutterMethodCall, result: @escaping FlutterResult) {
        TRTCCloud.sharedInstance()?.switchCamera();
        result(nil);
    }
    
    /**
     * 查询当前摄像头是否支持缩放。
     */
    public func isCameraZoomSupported(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(TRTCCloud.sharedInstance()?.isCameraZoomSupported());
    }
    
    /**
     * 设置摄像头缩放因子（焦距）。
     */
    public func setZoom(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let distance = CommonUtils.getParam(call: call, result: result, param: "distance") as? CGFloat{
            TRTCCloud.sharedInstance()?.setZoom(distance)
            result(nil);
        }
    }
    
    /**
     * 查询是否支持开关闪光灯（手电筒模式）。
     */
    public func isCameraTorchSupported(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(TRTCCloud.sharedInstance()?.isCameraTorchSupported());
    }
    
    /**
     * 开启闪光灯
     */
    public func enableTorch(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let enable = CommonUtils.getParam(call: call, result: result, param: "enable") as? Bool{
            TRTCCloud.sharedInstance()?.enbaleTorch(enable);
            result(nil);
        }
    }
    
    /**
     * 查询是否支持设置焦点。
     */
    public func isCameraFocusPositionInPreviewSupported(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(TRTCCloud.sharedInstance()?.isCameraFocusPositionInPreviewSupported());
    }
    
    /**
     * 设置摄像头焦点。
     */
    public func setFocusPosition(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let x = CommonUtils.getParam(call: call, result: result, param: "x") as? CGFloat,
            let y = CommonUtils.getParam(call: call, result: result, param: "y") as? CGFloat{
            TRTCCloud.sharedInstance()?.setFocusPosition( CGPoint(x: x, y: y));
            result(nil);
        }
    }
    
    /**
     * 查询是否支持自动识别人脸位置。
     */
    public func isCameraAutoFocusFaceModeSupported(call: FlutterMethodCall, result: @escaping FlutterResult) {
         result(TRTCCloud.sharedInstance()?.isCameraAutoFocusFaceModeSupported());
    }
}
