import Flutter
import TXLiteAVSDK_TRTC

public class SwiftTencentRtcPlugin: NSObject, FlutterPlugin, TRTCCloudDelegate {

    private static var channel: FlutterMethodChannel?;

    /**
     * 监听器回调的方法名
     */
    private static let LISTENER_FUNC_NAME = "onListener";

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tencent_rtc_plugin", binaryMessenger: registrar.messenger())
        SwiftTencentRtcPlugin.channel = channel;
        let instance = SwiftTencentRtcPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)

        // 绑定监听器
        TRTCCloud.sharedInstance()?.delegate = instance;

        // 视图工厂
        let viewFactory = TencentRtcVideoPlatformViewFactory(message: registrar.messenger());

        // 注册界面
        registrar.register(
                viewFactory,
                withId: TencentRtcVideoPlatformViewFactory.SIGN
        );
    }

    /**
     *  方法监听器
     */
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setConsoleEnabled":
            self.setConsoleEnabled(call: call, result: result);
            break;
        case "showDebugView":
            self.showDebugView(call: call, result: result);
            break;
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
        case "muteLocalVideo":
            self.muteLocalVideo(call: call, result: result);
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
     * 设置Debug视图
     */
    public func showDebugView(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int {
            TRTCCloud.sharedInstance()?.showDebugView(mode);
            result(nil);
        }
    }

    /**
     * 设置控制台打印
     */
    public func setConsoleEnabled(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let enabled = CommonUtils.getParam(call: call, result: result, param: "enabled") as? Bool {
            TRTCCloud.setConsoleEnabled(enabled);
            result(nil);
        }
    }

    /**
     * 进入房间
     */
    public func enterRoom(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let role = ((call.arguments as! [String: Any])["role"]) as? Int;
        let privateMapKey = ((call.arguments as! [String: Any])["privateMapKey"]) as? String;
        if let appid = CommonUtils.getParam(call: call, result: result, param: "appid") as? UInt32,
           let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
           let userSig = CommonUtils.getParam(call: call, result: result, param: "userSig") as? String,
           let roomId = CommonUtils.getParam(call: call, result: result, param: "roomId") as? UInt32,
           let scene = CommonUtils.getParam(call: call, result: result, param: "scene") as? Int {
            let params = TRTCParams();
            params.sdkAppId = appid;
            params.userId = userId;
            params.userSig = userSig;
            params.roomId = roomId;
            if role != nil {
                params.role = TRTCRoleType(rawValue: role!)!;
            }
            if privateMapKey != nil {
                params.privateMapKey = privateMapKey!;
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
        if let role = CommonUtils.getParam(call: call, result: result, param: "role") as? Int {
            TRTCCloud.sharedInstance()?.switch(TRTCRoleType(rawValue: role)!);
            result(nil);
        }
    }

    /**
     * 设置音视频数据接收模式（需要在进房前设置才能生效）。
     */
    public func setDefaultStreamRecvMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let autoRecvAudio = CommonUtils.getParam(call: call, result: result, param: "autoRecvAudio") as? Bool,
           let autoRecvVideo = CommonUtils.getParam(call: call, result: result, param: "autoRecvVideo") as? Bool {
            TRTCCloud.sharedInstance()?.setDefaultStreamRecvMode(autoRecvAudio, video: autoRecvVideo);
            result(nil);
        }
    }

    /**
     * 静音 / 取消静音
     */
    public func muteRemoteAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
           let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool {
            TRTCCloud.sharedInstance()?.muteRemoteAudio(userId, mute: mute);
            result(nil);
        }
    }

    /**
     * 静音 / 取消静音 所有用户
     */
    public func muteAllRemoteAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool {
            TRTCCloud.sharedInstance()?.muteAllRemoteAudio(mute);
            result(nil);
        }
    }

    /**
     * 设置远程显示填充模式
     */
    public func setRemoteViewFillMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
           let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int {
            TRTCCloud.sharedInstance()?.setRemoteViewFillMode(userId, mode: TRTCVideoFillMode(rawValue: mode)!)
            result(nil);
        }
    }

    /**
     * 设置本地显示填充模式
     */
    public func setLocalViewFillMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int {
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
           let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool {
            TRTCCloud.sharedInstance()?.muteRemoteVideoStream(userId, mute: mute);
            result(nil);
        }
    }

    /**
     * 停止接收所有远端视频流。
     */
    public func muteAllRemoteVideoStreams(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool {
            TRTCCloud.sharedInstance()?.muteAllRemoteVideoStreams(mute);
            result(nil);
        }
    }

    /**
     * 设置视频编码相关。
     */
    public func setVideoEncoderParam(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let param = CommonUtils.getParam(call: call, result: result, param: "param") as? String {
            let dict = JsonUtil.getDictionaryFromJSONString(jsonString: param);
            let data = TRTCVideoEncParam();
            if dict["videoBitrate"] != nil {
                data.videoBitrate = dict["videoBitrate"] as! Int32;
            }
            if dict["videoResolution"] != nil {
                data.videoResolution = TRTCVideoResolution(rawValue: dict["videoResolution"] as! Int)!;
            }
            if dict["videoResolutionMode"] != nil {
                data.resMode = TRTCVideoResolutionMode(rawValue: dict["videoResolutionMode"] as! Int)!;
            }
            if dict["videoFps"] != nil {
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
           let controlMode = CommonUtils.getParam(call: call, result: result, param: "controlMode") as? Int {
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
        if let rotation = CommonUtils.getParam(call: call, result: result, param: "rotation") as? Int {
            TRTCCloud.sharedInstance()?.setLocalViewRotation(TRTCVideoRotation(rawValue: rotation)!);
            result(nil);
        }
    }

    /**
     * 设置远端图像的顺时针旋转角度。
     */
    public func setRemoteViewRotation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userId = CommonUtils.getParam(call: call, result: result, param: "userId") as? String,
           let rotation = CommonUtils.getParam(call: call, result: result, param: "rotation") as? Int {
            TRTCCloud.sharedInstance()?.setRemoteViewRotation(userId, rotation: TRTCVideoRotation(rawValue: rotation)!)
            result(nil);
        }
    }

    /**
     * 设置视频编码输出的（也就是远端用户观看到的，以及服务器录制下来的）画面方向。
     */
    public func setVideoEncoderRotation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let rotation = CommonUtils.getParam(call: call, result: result, param: "rotation") as? Int {
            TRTCCloud.sharedInstance()?.setVideoEncoderRotation(TRTCVideoRotation(rawValue: rotation)!);
            result(nil);
        }
    }

    /**
     * 设置本地摄像头预览画面的镜像模式。
     */
    public func setLocalViewMirror(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mirrorType = CommonUtils.getParam(call: call, result: result, param: "mirrorType") as? UInt {
            TRTCCloud.sharedInstance()?.setLocalViewMirror(TRTCLocalVideoMirrorType(rawValue: mirrorType)!)
            result(nil);
        }
    }

    /**
     * 设置编码器输出的画面镜像模式。
     */
    public func setVideoEncoderMirror(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mirror = CommonUtils.getParam(call: call, result: result, param: "mirror") as? Bool {
            TRTCCloud.sharedInstance()?.setVideoEncoderMirror(mirror);
            result(nil);
        }
    }

    /**
     * 设置重力感应的适应模式。
     */
    public func setGSensorMode(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mode = CommonUtils.getParam(call: call, result: result, param: "mode") as? Int {
            TRTCCloud.sharedInstance()?.setGSensorMode(TRTCGSensorMode(rawValue: mode)!);
            result(nil);
        }
    }

    /**
     * 开启大小画面双路编码模式。
     */
    public func enableEncSmallVideoStream(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let enable = CommonUtils.getParam(call: call, result: result, param: "enable") as? Bool,
           let smallVideoEncParam = CommonUtils.getParam(call: call, result: result, param: "smallVideoEncParam") as? String {
            let dict = JsonUtil.getDictionaryFromJSONString(jsonString: smallVideoEncParam);
            let data = TRTCVideoEncParam();
            if dict["videoBitrate"] != nil {
                data.videoBitrate = dict["videoBitrate"] as! Int32;
            }
            if dict["videoResolution"] != nil {
                data.videoResolution = TRTCVideoResolution(rawValue: dict["videoResolution"] as! Int)!;
            }
            if dict["videoResolutionMode"] != nil {
                data.resMode = TRTCVideoResolutionMode(rawValue: dict["videoResolutionMode"] as! Int)!;
            }
            if dict["videoFps"] != nil {
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
           let streamType = CommonUtils.getParam(call: call, result: result, param: "streamType") as? Int {
            TRTCCloud.sharedInstance()?.setRemoteVideoStreamType(userId, type: TRTCVideoStreamType(rawValue: streamType)!);
            result(nil);
        }
    }

    /**
     * 设定观看方优先选择的视频质量。
     */
    public func setPriorRemoteVideoStreamType(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let streamType = CommonUtils.getParam(call: call, result: result, param: "streamType") as? Int {
            TRTCCloud.sharedInstance()?.setPriorRemoteVideoStreamType(TRTCVideoStreamType(rawValue: streamType)!);
            result(nil);
        }
    }

    /**
     * 静音本地的音频。
     */
    public func muteLocalAudio(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool {
            TRTCCloud.sharedInstance()?.muteLocalAudio(mute);
            result(nil);
        }
    }

    /**
     * 关闭本地的视频。
     */
    public func muteLocalVideo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let mute = CommonUtils.getParam(call: call, result: result, param: "mute") as? Bool {
            TRTCCloud.sharedInstance()?.muteLocalVideo(mute);
            result(nil);
        }
    }

    /**
     * 设置音频路由。
     */
    public func setAudioRoute(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let route = CommonUtils.getParam(call: call, result: result, param: "route") as? Int {
            TRTCCloud.sharedInstance()?.setAudioRoute(TRTCAudioRoute(rawValue: route)!);
            result(nil);
        }
    }

    /**
     * 启用音量大小提示。
     */
    public func enableAudioVolumeEvaluation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let intervalMs = CommonUtils.getParam(call: call, result: result, param: "intervalMs") as? UInt {
            TRTCCloud.sharedInstance()?.enableAudioVolumeEvaluation(intervalMs);
            result(nil);
        }
    }

    /**
     * 开始录音。
     */
    public func startAudioRecording(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let filePath = CommonUtils.getParam(call: call, result: result, param: "filePath") as? String {
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
        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? Int {
            TRTCCloud.sharedInstance()?.setSystemVolumeType(TRTCSystemVolumeType(rawValue: type)!);
            result(nil);
        }
    }

    /**
     * 开启耳返。
     */
    public func enableAudioEarMonitoring(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let enable = CommonUtils.getParam(call: call, result: result, param: "enable") as? Bool {
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
        if let distance = CommonUtils.getParam(call: call, result: result, param: "distance") as? CGFloat {
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
        if let enable = CommonUtils.getParam(call: call, result: result, param: "enable") as? Bool {
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
           let y = CommonUtils.getParam(call: call, result: result, param: "y") as? CGFloat {
            TRTCCloud.sharedInstance()?.setFocusPosition(CGPoint(x: x, y: y));
            result(nil);
        }
    }

    /**
     * 查询是否支持自动识别人脸位置。
     */
    public func isCameraAutoFocusFaceModeSupported(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(TRTCCloud.sharedInstance()?.isCameraAutoFocusFaceModeSupported());
    }

    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    private func invokeListener(type: ListenerType, params: Any?) {
        var resultParams: [String: Any] = [:];
        resultParams["type"] = type;
        if let p = params {
            resultParams["params"] = JsonUtil.toJson(p);
        }
        SwiftTencentRtcPlugin.channel!.invokeMethod(SwiftTencentRtcPlugin.LISTENER_FUNC_NAME, arguments: JsonUtil.toJson(resultParams));
    }

    /**
     * SDK加载错误回调
     * 错误通知是要监听的，错误通知意味着 SDK 不能继续运行了
     */
    public func onError(_ errCode: TXLiteAVError, errMsg: String?, extInfo: [AnyHashable: Any]?) {
        self.invokeListener(type: ListenerType.SdkError, params: ["code": errCode.rawValue, "msg": errMsg]);
    }

    /**
     * 警告回调，用于告知您一些非严重性问题，例如出现卡顿或者可恢复的解码失败。
     */
    public func onWarning(_ warningCode: TXLiteAVWarning, warningMsg: String?, extInfo: [AnyHashable: Any]?) {
        self.invokeListener(type: ListenerType.Warning, params: ["code": warningCode.rawValue, "msg": warningMsg]);
    }

    /**
     *  进入房间回调
     */
    public func onEnterRoom(_ result: Int) {
        self.invokeListener(type: ListenerType.EnterRoom, params: result);
    }

    /**
     * 退出房间监听器
     */
    public func onExitRoom(_ reason: Int) {
        self.invokeListener(type: ListenerType.ExitRoom, params: reason);
    }

    /**
     * 切换角色
     */
    public func onSwitchRole(_ errCode: TXLiteAVError, errMsg: String?) {
        self.invokeListener(type: ListenerType.SwitchRole, params: ["code": errCode.rawValue, "msg": errMsg]);
    }

    /**
     * 请求跨房通话（主播 PK）的结果回调。
     */
    public func onConnectOtherRoom(_ userId: String, errCode: TXLiteAVError, errMsg: String?) {
        self.invokeListener(type: ListenerType.ConnectOtherRoom, params: ["userId": userId, "code": errCode.rawValue, "msg": errMsg]);
    }

    /**
     * 结束跨房通话（主播 PK）的结果回调。
     */
    public func onDisconnectOtherRoom(_ errCode: TXLiteAVError, errMsg: String?) {
        self.invokeListener(type: ListenerType.DisConnectOtherRoom, params: ["code": errCode.rawValue, "msg": errMsg]);
    }

    /**
     * 有用户加入当前房间。
     */
    public func onRemoteUserEnterRoom(_ userId: String) {
        self.invokeListener(type: ListenerType.RemoteUserEnterRoom, params: userId);
    }

    /**
     * 有用户离开当前房间。
     */
    public func onRemoteUserLeaveRoom(_ userId: String, reason: Int) {
        self.invokeListener(type: ListenerType.RemoteUserLeaveRoom, params: ["userId": userId, "reason": reason]);
    }

    /**
     * 有用户上传视频数据
     */
    public func onUserVideoAvailable(_ userId: String, available: Bool) {
        self.invokeListener(type: ListenerType.UserVideoAvailable, params: ["userId": userId, "available": available]);
    }

    /**
     * 有用户上传屏幕数据
     */
    public func onUserSubStreamAvailable(_ userId: String, available: Bool) {
        self.invokeListener(type: ListenerType.UserSubStreamAvailable, params: ["userId": userId, "available": available]);
    }

    /**
     * 有用户上传音频数据
     */
    public func onUserAudioAvailable(_ userId: String, available: Bool) {
        self.invokeListener(type: ListenerType.UserAudioAvailable, params: ["userId": userId, "available": available]);
    }

    /**
     * 开始渲染本地或远程用户的首帧画面。
     */
    public func onFirstVideoFrame(_ userId: String, streamType: TRTCVideoStreamType, width: Int32, height: Int32) {
        self.invokeListener(type: ListenerType.FirstVideoFrame, params: ["userId": userId, "streamType": streamType.rawValue, "width": width, "height": height]);
    }

    /**
     * 开始播放远程用户的首帧音频（本地声音暂不通知）。
     */
    public func onFirstAudioFrame(_ userId: String) {
        self.invokeListener(type: ListenerType.FirstAudioFrame, params: userId);
    }

    /**
     * 首帧本地视频数据已经被送出。
     */
    public func onSendFirstLocalVideoFrame(_ streamType: TRTCVideoStreamType) {
        self.invokeListener(type: ListenerType.SendFirstLocalVideoFrame, params: streamType.rawValue);
    }

    /**
     * 首帧本地音频数据已经被送出。
     */
    public func onSendFirstLocalAudioFrame() {
        self.invokeListener(type: ListenerType.SendFirstLocalAudioFrame, params: nil);
    }

    /**
     * 网络质量：该回调每2秒触发一次，统计当前网络的上行和下行质量。
     */
    public func onNetworkQuality(_ localQuality: TRTCQualityInfo, remoteQuality: [TRTCQualityInfo]) {

        var remoteQualityArray: [Any] = [];
        for item in remoteQuality {
            remoteQualityArray.append(["userId": item.userId, "quality": item.quality.rawValue]);
        }

        self.invokeListener(type: ListenerType.NetworkQuality, params: [
            "localQuality": [
                "userId": localQuality.userId,
                "quality": localQuality.quality.rawValue
            ],
            "remoteQuality": remoteQualityArray
        ]);
    }

    /**
     * 技术指标统计回调:。
     */
    public func onStatistics(_ statistics: TRTCStatistics) {

        var localArray: [Any] = [];
        var remoteArray: [Any] = [];

        for item in statistics.localStatistics {
            localArray.append([
                "width": item.width,
                "height": item.height,
                "frameRate": item.frameRate,
                "videoBitrate": item.videoBitrate,
                "audioSampleRate": item.audioSampleRate,
                "audioBitrate": item.audioBitrate,
                "streamType": item.streamType.rawValue
            ]);
        }

        for item in statistics.remoteStatistics {
            remoteArray.append([
                "userId": item.userId,
                "finalLoss": item.finalLoss,
                "width": item.width,
                "height": item.height,
                "frameRate": item.frameRate,
                "videoBitrate": item.videoBitrate,
                "audioSampleRate": item.audioSampleRate,
                "audioBitrate": item.audioBitrate,
                "streamType": item.streamType.rawValue
            ]);
        }

        self.invokeListener(type: ListenerType.Statistics, params: [
            "appCpu": statistics.appCpu,
            "systemCpu": statistics.systemCpu,
            "rtt": statistics.rtt,
            "upLoss": statistics.upLoss,
            "downLoss": statistics.downLoss,
            "sendBytes": statistics.sentBytes,
            "receiveBytes": statistics.receivedBytes,
            "localArray": localArray,
            "remoteArray": remoteArray
        ]);
    }

    /**
     * 跟服务器断开
     */
    public func onConnectionLost() {
        self.invokeListener(type: ListenerType.ConnectionLost, params: nil);
    }

    /**
     * SDK 尝试重新连接到服务器。
     */
    public func onTryToReconnect() {
        self.invokeListener(type: ListenerType.TryToReconnect, params: nil);
    }

    /**
     * SDK 跟服务器的连接恢复。
     */
    public func onConnectionRecovery() {
        self.invokeListener(type: ListenerType.ConnectionRecovery, params: nil);
    }

    /**
     * 摄像头准备就绪。
     */
    public func onCameraDidReady() {
        self.invokeListener(type: ListenerType.CameraDidReady, params: nil);
    }

    /**
     * 麦克风准备就绪。
     */
    public func onMicDidReady() {
        self.invokeListener(type: ListenerType.MicDidReady, params: nil);
    }

    /**
     * 音频路由发生变化，音频路由即声音由哪里输出（扬声器、听筒）。
     */
    public func onAudioRouteChanged(_ route: TRTCAudioRoute, from fromRoute: TRTCAudioRoute) {
        self.invokeListener(type: ListenerType.AudioRouteChanged, params: ["newRoute": route.rawValue, "oldRoute": fromRoute.rawValue]);
    }


    /**
     * 用于提示音量大小的回调，包括每个 userId 的音量和远端总音量。
     */
    public func onUserVoiceVolume(_ userVolumes: [TRTCVolumeInfo], totalVolume: Int) {
        var userVolumeArray: [Any] = [];
        for item in userVolumes {
            userVolumeArray.append([
                "userId": item.userId,
                "volume": item.volume
            ]);
        }

        self.invokeListener(type: ListenerType.UserVoiceVolume, params: ["userVolumes": userVolumeArray, "totalVolume": totalVolume]);
    }

    /**
     * 收到自定义消息
     */
    public func onRecvCustomCmdMsgUserId(_ userId: String, cmdID: Int, seq: UInt32, message: Data) {
        self.invokeListener(type: ListenerType.RecvCustomCmdMsg, params: [
            "userId": userId,
            "cmdID": cmdID,
            "seq": seq,
            "message": message
        ]);
    }

    /**
     * 自定义消息丢失
     */
    public func onMissCustomCmdMsgUserId(_ userId: String, cmdID: Int, errCode: Int, missed: Int) {
        self.invokeListener(type: ListenerType.MissCustomCmdMsg, params: [
            "userId": userId,
            "cmdID": cmdID,
            "errCode": errCode,
            "missed": missed
        ]);
    }

    /**
     * 收到SEI消息
     */
    public func onRecvSEIMsg(_ userId: String, message: Data) {
        self.invokeListener(type: ListenerType.RecvSEIMsg, params: [
            "userId": userId,
            "data": message
        ]);
    }

    /**
     * 启动旁路推流到 CDN 完成的回调。
     */
    public func onStartPublishCDNStream(_ err: Int32, errMsg: String) {
        self.invokeListener(type: ListenerType.StartPublishCDNStream, params: [
            "err": err,
            "errMsg": errMsg
        ]);
    }

    /**
     * 停止旁路推流到 CDN 完成的回调。
     */
    public func onStopPublishCDNStream(_ err: Int32, errMsg: String) {
        self.invokeListener(type: ListenerType.StopPublishCDNStream, params: [
            "err": err,
            "errMsg": errMsg
        ]);
    }

    /**
     * 设置云端的混流转码参数的回调，对应于 TRTCCloud 中的 setMixTranscodingConfig() 接口。
     */
    public func onSetMixTranscodingConfig(_ err: Int32, errMsg: String) {
        self.invokeListener(type: ListenerType.SetMixTranscodingConfig, params: [
            "err": err,
            "errMsg": errMsg
        ]);
    }

    /**
     * 播放音效结束回调。
     */
    public func onAudioEffectFinished(_ effectId: Int32, code: Int32) {
        self.invokeListener(type: ListenerType.AudioEffectFinished, params: [
            "effectId": effectId,
            "code": code
        ]);
    }
}
