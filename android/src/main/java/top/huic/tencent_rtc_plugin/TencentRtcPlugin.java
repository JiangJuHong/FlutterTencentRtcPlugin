package top.huic.tencent_rtc_plugin;

import android.content.Context;
import android.graphics.BitmapFactory;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.tencent.trtc.TRTCCloud;
import com.tencent.trtc.TRTCCloudDef;
import com.tencent.trtc.TRTCCloudListener;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.platform.PlatformViewRegistry;
import top.huic.tencent_rtc_plugin.listener.CustomTRTCAudioFrameListener;
import top.huic.tencent_rtc_plugin.listener.CustomTRTCCloudListener;
import top.huic.tencent_rtc_plugin.listener.CustomTRTCLogListener;
import top.huic.tencent_rtc_plugin.util.GenerateTestUserSig;
import top.huic.tencent_rtc_plugin.util.TencentRtcPluginUtil;
import top.huic.tencent_rtc_plugin.view.TencentRtcVideoPlatformView;

/**
 * TencentRtcPlugin
 */
public class TencentRtcPlugin implements FlutterPlugin, MethodCallHandler {
    /**
     * 腾讯云音视频通信实例
     */
    private TRTCCloud trtcCloud;

    public TencentRtcPlugin() {
    }

    private TencentRtcPlugin(BinaryMessenger messenger, Context context, MethodChannel channel, PlatformViewRegistry registry) {
        // 初始化实例
        trtcCloud = TRTCCloud.sharedInstance(context);
        trtcCloud.setListener(new CustomTRTCCloudListener(channel));
        trtcCloud.setAudioFrameListener(new CustomTRTCAudioFrameListener(channel));
        TRTCCloud.setLogListener(new CustomTRTCLogListener(channel));

        // 注册View
        registry.registerViewFactory(TencentRtcVideoPlatformView.SIGN, new TencentRtcVideoPlatformView(context, messenger));
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tencent_rtc_plugin");
        channel.setMethodCallHandler(new TencentRtcPlugin(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext(), channel, flutterPluginBinding.getPlatformViewRegistry()));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        if (registrar.activity() == null) { // from background service , like firebase
            return;
        }
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "tencent_rtc_plugin");
        channel.setMethodCallHandler(new TencentRtcPlugin(registrar.messenger(), registrar.context(), channel, registrar.platformViewRegistry()));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "setConsoleEnabled":
                this.setConsoleEnabled(call, result);
                break;
            case "showDebugView":
                this.showDebugView(call, result);
                break;
            case "enterRoom":
                this.enterRoom(call, result);
                break;
            case "exitRoom":
                this.exitRoom(call, result);
                break;
            case "switchRole":
                this.switchRole(call, result);
                break;
            case "connectOtherRoom":
                this.connectOtherRoom(call, result);
                break;
            case "disconnectOtherRoom":
                this.disconnectOtherRoom(call, result);
                break;
            case "setDefaultStreamRecvMode":
                this.setDefaultStreamRecvMode(call, result);
                break;
            case "startPublishing":
                this.startPublishing(call, result);
                break;
            case "stopPublishing":
                this.stopPublishing(call, result);
                break;
            case "startPublishCDNStream":
                this.startPublishCDNStream(call, result);
                break;
            case "stopPublishCDNStream":
                this.stopPublishCDNStream(call, result);
                break;
            case "stopLocalPreview":
                this.stopLocalPreview(call, result);
                break;
            case "stopRemoteView":
                this.stopRemoteView(call, result);
                break;
            case "muteLocalVideo":
                this.muteLocalVideo(call, result);
                break;
            case "setVideoMuteImage":
                this.setVideoMuteImage(call, result);
                break;
            case "stopAllRemoteView":
                this.stopAllRemoteView(call, result);
                break;
            case "muteRemoteAudio":
                this.muteRemoteAudio(call, result);
                break;
            case "muteAllRemoteAudio":
                this.muteAllRemoteAudio(call, result);
                break;
            case "setAudioCaptureVolume":
                this.setAudioCaptureVolume(call, result);
                break;
            case "getAudioCaptureVolume":
                this.getAudioCaptureVolume(call, result);
                break;
            case "setAudioPlayoutVolume":
                this.setAudioPlayoutVolume(call, result);
                break;
            case "getAudioPlayoutVolume":
                this.getAudioPlayoutVolume(call, result);
                break;
            case "setRemoteViewFillMode":
                this.setRemoteViewFillMode(call, result);
                break;
            case "setLocalViewFillMode":
                this.setLocalViewFillMode(call, result);
                break;
            case "startLocalAudio":
                this.startLocalAudio(call, result);
                break;
            case "stopLocalAudio":
                this.stopLocalAudio(call, result);
                break;
            case "muteRemoteVideoStream":
                this.muteRemoteVideoStream(call, result);
                break;
            case "muteAllRemoteVideoStreams":
                this.muteAllRemoteVideoStreams(call, result);
                break;
            case "setVideoEncoderParam":
                this.setVideoEncoderParam(call, result);
                break;
            case "setNetworkQosParam":
                this.setNetworkQosParam(call, result);
                break;
            case "setLocalViewRotation":
                this.setLocalViewRotation(call, result);
                break;
            case "setRemoteViewRotation":
                this.setRemoteViewRotation(call, result);
                break;
            case "setVideoEncoderRotation":
                this.setVideoEncoderRotation(call, result);
                break;
            case "setLocalViewMirror":
                this.setLocalViewMirror(call, result);
                break;
            case "setVideoEncoderMirror":
                this.setVideoEncoderMirror(call, result);
                break;
            case "setGSensorMode":
                this.setGSensorMode(call, result);
                break;
            case "enableEncSmallVideoStream":
                this.enableEncSmallVideoStream(call, result);
                break;
            case "setRemoteVideoStreamType":
                this.setRemoteVideoStreamType(call, result);
                break;
            case "setPriorRemoteVideoStreamType":
                this.setPriorRemoteVideoStreamType(call, result);
                break;
            case "setAudioQuality":
                this.setAudioQuality(call, result);
                break;
            case "muteLocalAudio":
                this.muteLocalAudio(call, result);
                break;
            case "setAudioRoute":
                this.setAudioRoute(call, result);
                break;
            case "enableAudioVolumeEvaluation":
                this.enableAudioVolumeEvaluation(call, result);
                break;
            case "startAudioRecording":
                this.startAudioRecording(call, result);
                break;
            case "stopAudioRecording":
                this.stopAudioRecording(call, result);
                break;
            case "setSystemVolumeType":
                this.setSystemVolumeType(call, result);
                break;
            case "enableAudioEarMonitoring":
                this.enableAudioEarMonitoring(call, result);
                break;
            case "switchCamera":
                this.switchCamera(call, result);
                break;
            case "isCameraZoomSupported":
                this.isCameraZoomSupported(call, result);
                break;
            case "setZoom":
                this.setZoom(call, result);
                break;
            case "isCameraTorchSupported":
                this.isCameraTorchSupported(call, result);
                break;
            case "enableTorch":
                this.enableTorch(call, result);
                break;
            case "isCameraFocusPositionInPreviewSupported":
                this.isCameraFocusPositionInPreviewSupported(call, result);
                break;
            case "setFocusPosition":
                this.setFocusPosition(call, result);
                break;
            case "isCameraAutoFocusFaceModeSupported":
                this.isCameraAutoFocusFaceModeSupported(call, result);
                break;
            case "setWatermark":
                this.setWatermark(call, result);
                break;
            case "stopScreenCapture":
                this.stopScreenCapture(call, result);
                break;
            case "pauseScreenCapture":
                this.pauseScreenCapture(call, result);
                break;
            case "resumeScreenCapture":
                this.resumeScreenCapture(call, result);
                break;
            case "stopRemoteSubStreamView":
                this.stopRemoteSubStreamView(call, result);
                break;
            case "setRemoteSubStreamViewFillMode":
                this.setRemoteSubStreamViewFillMode(call, result);
                break;
            case "setRemoteSubStreamViewRotation":
                this.setRemoteSubStreamViewRotation(call, result);
                break;
            case "sendCustomCmdMsg":
                this.sendCustomCmdMsg(call, result);
                break;
            case "sendSEIMsg":
                this.sendSEIMsg(call, result);
                break;
            case "startSpeedTest":
                this.startSpeedTest(call, result);
                break;
            case "stopSpeedTest":
                this.stopSpeedTest(call, result);
                break;
            case "getSDKVersion":
                this.getSDKVersion(call, result);
                break;
            case "setLogLevel":
                this.setLogLevel(call, result);
                break;
            case "setLogCompressEnabled":
                this.setLogCompressEnabled(call, result);
                break;
            case "setLogDirPath":
                this.setLogDirPath(call, result);
                break;
            case "setDebugViewMargin":
                this.setDebugViewMargin(call, result);
                break;
            case "genUserSig":
                this.genUserSig(call, result);
                break;
            default:
                result.notImplemented();
        }

    }

    /**
     * 设置Debug视图
     */
    private void showDebugView(@NonNull MethodCall call, @NonNull Result result) {
        int mode = TencentRtcPluginUtil.getParam(call, result, "mode");
        trtcCloud.showDebugView(mode);
        result.success(null);
    }

    /**
     * 设置日志显示
     */
    private void setConsoleEnabled(@NonNull MethodCall call, @NonNull Result result) {
        boolean enabled = TencentRtcPluginUtil.getParam(call, result, "enabled");
        TRTCCloud.setConsoleEnabled(enabled);
        result.success(null);
    }

    /**
     * 进入房间
     */
    private void enterRoom(@NonNull MethodCall call, @NonNull Result result) {
        TRTCCloudDef.TRTCParams trtcParams = new TRTCCloudDef.TRTCParams();
        trtcParams.sdkAppId = TencentRtcPluginUtil.getParam(call, result, "appid");
        trtcParams.userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        trtcParams.userSig = TencentRtcPluginUtil.getParam(call, result, "userSig");
        trtcParams.roomId = TencentRtcPluginUtil.getParam(call, result, "roomId");
        int scene = TencentRtcPluginUtil.getParam(call, result, "scene");
        Integer role = call.argument("role");
        String privateMapKey = call.argument("privateMapKey");
        if (role != null) {
            trtcParams.role = role;
        }
        if (privateMapKey != null) {
            trtcParams.privateMapKey = privateMapKey;
        }
        trtcCloud.enterRoom(trtcParams, scene);
        result.success(null);
    }

    /**
     * 退出房间
     */
    private void exitRoom(@NonNull MethodCall call, @NonNull Result result) {
        trtcCloud.exitRoom();
        result.success(null);
    }

    /**
     * 切换角色
     */
    private void switchRole(@NonNull MethodCall call, @NonNull Result result) {
        int role = TencentRtcPluginUtil.getParam(call, result, "role");
        trtcCloud.switchRole(role);
        result.success(null);
    }

    /**
     * 请求跨房通话（主播 PK）
     */
    private void connectOtherRoom(@NonNull MethodCall call, @NonNull Result result) {
        String param = TencentRtcPluginUtil.getParam(call, result, "param");
        trtcCloud.ConnectOtherRoom(param);
        result.success(null);
    }

    /**
     * 退出跨房通话
     */
    private void disconnectOtherRoom(@NonNull MethodCall call, @NonNull Result result) {
        trtcCloud.DisconnectOtherRoom();
        result.success(null);
    }

    /**
     * 设置音视频数据接收模式（需要在进房前设置才能生效）。
     */
    private void setDefaultStreamRecvMode(@NonNull MethodCall call, @NonNull Result result) {
        boolean autoRecvAudio = TencentRtcPluginUtil.getParam(call, result, "autoRecvAudio");
        boolean autoRecvVideo = TencentRtcPluginUtil.getParam(call, result, "autoRecvVideo");
        trtcCloud.setDefaultStreamRecvMode(autoRecvAudio, autoRecvVideo);
        result.success(null);
    }

    /**
     * 开始向腾讯云的直播 CDN 推流
     */
    private void startPublishing(@NonNull MethodCall call, @NonNull Result result) {
        String streamId = TencentRtcPluginUtil.getParam(call, result, "streamId");
        int streamType = TencentRtcPluginUtil.getParam(call, result, "streamType");
        trtcCloud.startPublishing(streamId, streamType);
        result.success(null);
    }


    /**
     * 停止向腾讯云的直播 CDN 推流
     */
    private void stopPublishing(@NonNull MethodCall call, @NonNull Result result) {
        trtcCloud.stopPublishing();
        result.success(null);
    }

    /**
     * 开始向友商云的直播 CDN 转推
     */
    private void startPublishCDNStream(@NonNull MethodCall call, @NonNull Result result) {
        int appid = TencentRtcPluginUtil.getParam(call, result, "appid");
        int bizId = TencentRtcPluginUtil.getParam(call, result, "bizId");
        String url = TencentRtcPluginUtil.getParam(call, result, "url");

        TRTCCloudDef.TRTCPublishCDNParam param = new TRTCCloudDef.TRTCPublishCDNParam();
        param.appId = appid;
        param.bizId = bizId;
        param.url = url;
        trtcCloud.startPublishCDNStream(param);
        result.success(null);
    }


    /**
     * 停止向非腾讯云地址转推
     */
    private void stopPublishCDNStream(@NonNull MethodCall call, @NonNull Result result) {
        trtcCloud.stopPublishCDNStream();
        result.success(null);
    }

    /**
     * 停止本地视频采集
     */
    private void stopLocalPreview(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.stopLocalPreview();
        result.success(null);
    }

    /**
     * 停止远程显示
     */
    private void stopRemoteView(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        trtcCloud.stopRemoteView(userId);
        result.success(null);
    }

    /**
     * 静音 / 取消静音
     */
    private void muteRemoteAudio(@NonNull MethodCall call, @NonNull Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteRemoteAudio(userId, mute);
        result.success(null);
    }

    /**
     * 静音 / 取消静音 所有用户
     */
    private void muteAllRemoteAudio(@NonNull MethodCall call, @NonNull Result result) {
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteAllRemoteAudio(mute);
        result.success(null);
    }

    /**
     * 设置 SDK 采集音量。
     */
    private void setAudioCaptureVolume(@NonNull MethodCall call, @NonNull Result result) {
        int volume = TencentRtcPluginUtil.getParam(call, result, "volume");
        trtcCloud.setAudioCaptureVolume(volume);
        result.success(null);
    }

    /**
     * 获得 SDK 采集音量。
     */
    private void getAudioCaptureVolume(@NonNull MethodCall call, @NonNull Result result) {
        result.success(trtcCloud.getAudioCaptureVolume());
    }

    /**
     * 设置 SDK 播放音量。
     */
    private void setAudioPlayoutVolume(@NonNull MethodCall call, @NonNull Result result) {
        int volume = TencentRtcPluginUtil.getParam(call, result, "volume");
        trtcCloud.setAudioPlayoutVolume(volume);
        result.success(null);
    }

    /**
     * 获得 SDK 播放音量。
     */
    private void getAudioPlayoutVolume(@NonNull MethodCall call, @NonNull Result result) {
        result.success(trtcCloud.getAudioPlayoutVolume());
    }

    /**
     * 设置远程显示填充模式
     */
    private void setRemoteViewFillMode(@NonNull MethodCall call, @NonNull Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        int mode = TencentRtcPluginUtil.getParam(call, result, "mode");
        trtcCloud.setRemoteViewFillMode(userId, mode);
        result.success(null);
    }

    /**
     * 设置本地显示填充模式
     */
    private void setLocalViewFillMode(@NonNull MethodCall call, @NonNull Result result) {
        int mode = TencentRtcPluginUtil.getParam(call, result, "mode");
        trtcCloud.setLocalViewFillMode(mode);
        result.success(null);
    }

    /**
     * 开启本地音频采集
     */
    private void startLocalAudio(@NonNull MethodCall call, @NonNull Result result) {
        trtcCloud.startLocalAudio();
        result.success(null);
    }

    /**
     * 关闭本地音频采集
     */
    private void stopLocalAudio(@NonNull MethodCall call, @NonNull Result result) {
        trtcCloud.stopLocalAudio();
        result.success(null);
    }

    /**
     * 停止显示所有远端视频画面。
     */
    private void stopAllRemoteView(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.stopAllRemoteView();
        result.success(null);
    }

    /**
     * 暂停接收指定的远端视频流。
     */
    private void muteRemoteVideoStream(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteRemoteVideoStream(userId, mute);
        result.success(null);
    }

    /**
     * 停止接收所有远端视频流。
     */
    private void muteAllRemoteVideoStreams(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteAllRemoteVideoStreams(mute);
        result.success(null);
    }

    /**
     * 设置视频编码相关。
     */
    private void setVideoEncoderParam(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String param = TencentRtcPluginUtil.getParam(call, result, "param");
        trtcCloud.setVideoEncoderParam(JSON.parseObject(param, TRTCCloudDef.TRTCVideoEncParam.class));
        result.success(null);
    }

    /**
     * 设置网络流控相关参数。
     */
    private void setNetworkQosParam(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        TRTCCloudDef.TRTCNetworkQosParam params = new TRTCCloudDef.TRTCNetworkQosParam();
        params.preference = TencentRtcPluginUtil.getParam(call, result, "preference");
        params.controlMode = TencentRtcPluginUtil.getParam(call, result, "controlMode");
        trtcCloud.setNetworkQosParam(params);
        result.success(null);
    }

    /**
     * 设置本地图像的顺时针旋转角度。
     */
    private void setLocalViewRotation(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int rotation = TencentRtcPluginUtil.getParam(call, result, "rotation");
        trtcCloud.setLocalViewRotation(rotation);
        result.success(null);
    }

    /**
     * 设置远端图像的顺时针旋转角度。
     */
    private void setRemoteViewRotation(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        int rotation = TencentRtcPluginUtil.getParam(call, result, "rotation");
        trtcCloud.setRemoteViewRotation(userId, rotation);
        result.success(null);
    }

    /**
     * 设置视频编码输出的（也就是远端用户观看到的，以及服务器录制下来的）画面方向。
     */
    private void setVideoEncoderRotation(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int rotation = TencentRtcPluginUtil.getParam(call, result, "rotation");
        trtcCloud.setVideoEncoderRotation(rotation);
        result.success(null);
    }

    /**
     * 设置本地摄像头预览画面的镜像模式。
     */
    private void setLocalViewMirror(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int mirrorType = TencentRtcPluginUtil.getParam(call, result, "mirrorType");
        trtcCloud.setLocalViewMirror(mirrorType);
        result.success(null);
    }

    /**
     * 设置编码器输出的画面镜像模式。
     */
    private void setVideoEncoderMirror(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean mirror = TencentRtcPluginUtil.getParam(call, result, "mirror");
        trtcCloud.setVideoEncoderMirror(mirror);
        result.success(null);
    }

    /**
     * 设置重力感应的适应模式。
     */
    private void setGSensorMode(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int mode = TencentRtcPluginUtil.getParam(call, result, "mode");
        trtcCloud.setGSensorMode(mode);
        result.success(null);
    }

    /**
     * 开启大小画面双路编码模式。
     */
    private void enableEncSmallVideoStream(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean enable = TencentRtcPluginUtil.getParam(call, result, "enable");
        String smallVideoEncParam = TencentRtcPluginUtil.getParam(call, result, "smallVideoEncParam");
        result.success(trtcCloud.enableEncSmallVideoStream(enable, JSON.parseObject(smallVideoEncParam, TRTCCloudDef.TRTCVideoEncParam.class)));
    }

    /**
     * 选定观看指定 uid 的大画面或小画面。
     */
    private void setRemoteVideoStreamType(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        int streamType = TencentRtcPluginUtil.getParam(call, result, "streamType");
        trtcCloud.setRemoteVideoStreamType(userId, streamType);
        result.success(null);
    }

    /**
     * 设定观看方优先选择的视频质量。
     */
    private void setPriorRemoteVideoStreamType(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int streamType = TencentRtcPluginUtil.getParam(call, result, "streamType");
        trtcCloud.setPriorRemoteVideoStreamType(streamType);
        result.success(null);
    }

    /**
     * 设置音频质量。
     */
    private void setAudioQuality(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int quality = TencentRtcPluginUtil.getParam(call, result, "quality");
        trtcCloud.setAudioQuality(quality);
        result.success(null);
    }

    /**
     * 静音本地的音频。
     */
    private void muteLocalAudio(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteLocalAudio(mute);
        result.success(null);
    }

    /**
     * 关闭本地的视频。
     */
    private void muteLocalVideo(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteLocalVideo(mute);
        result.success(null);
    }

    /**
     * 设置暂停推送本地视频时要推送的图片。
     */
    private void setVideoMuteImage(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String image = call.argument("image");
        int fps = TencentRtcPluginUtil.getParam(call, result, "fps");
        trtcCloud.setVideoMuteImage(image == null ? null : BitmapFactory.decodeFile(image), fps);
        result.success(null);
    }

    /**
     * 设置音频路由。
     */
    private void setAudioRoute(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int route = TencentRtcPluginUtil.getParam(call, result, "route");
        trtcCloud.setAudioRoute(route);
        result.success(null);
    }

    /**
     * 启用音量大小提示。
     */
    private void enableAudioVolumeEvaluation(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int intervalMs = TencentRtcPluginUtil.getParam(call, result, "intervalMs");
        trtcCloud.enableAudioVolumeEvaluation(intervalMs);
        result.success(null);
    }

    /**
     * 开始录音。
     */
    private void startAudioRecording(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        TRTCCloudDef.TRTCAudioRecordingParams params = new TRTCCloudDef.TRTCAudioRecordingParams();
        params.filePath = TencentRtcPluginUtil.getParam(call, result, "filePath");
        trtcCloud.startAudioRecording(params);
        result.success(null);
    }

    /**
     * 停止录音。
     */
    private void stopAudioRecording(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.stopAudioRecording();
        result.success(null);
    }

    /**
     * 设置通话时使用的系统音量类型。
     */
    private void setSystemVolumeType(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int type = TencentRtcPluginUtil.getParam(call, result, "type");
        trtcCloud.setSystemVolumeType(type);
        result.success(null);
    }

    /**
     * 开启耳返。
     */
    private void enableAudioEarMonitoring(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean enable = TencentRtcPluginUtil.getParam(call, result, "enable");
        trtcCloud.enableAudioEarMonitoring(enable);
        result.success(null);
    }

    /**
     * 切换摄像头。
     */
    private void switchCamera(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.switchCamera();
        result.success(null);
    }

    /**
     * 查询当前摄像头是否支持缩放。
     */
    private void isCameraZoomSupported(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.success(trtcCloud.isCameraZoomSupported());
    }

    /**
     * 设置摄像头缩放因子（焦距）。
     */
    private void setZoom(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int distance = TencentRtcPluginUtil.getParam(call, result, "distance");
        trtcCloud.setZoom(distance);
        result.success(null);
    }

    /**
     * 查询是否支持开关闪光灯（手电筒模式）。
     */
    private void isCameraTorchSupported(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.success(trtcCloud.isCameraTorchSupported());
    }

    /**
     * 开启闪光灯
     */
    private void enableTorch(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean enable = TencentRtcPluginUtil.getParam(call, result, "enable");
        trtcCloud.enableTorch(enable);
        result.success(null);
    }

    /**
     * 查询是否支持设置焦点。
     */
    private void isCameraFocusPositionInPreviewSupported(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.success(trtcCloud.isCameraFocusPositionInPreviewSupported());
    }

    /**
     * 设置摄像头焦点。
     */
    private void setFocusPosition(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int x = TencentRtcPluginUtil.getParam(call, result, "x");
        int y = TencentRtcPluginUtil.getParam(call, result, "y");
        trtcCloud.setFocusPosition(x, y);
        result.success(null);
    }

    /**
     * 查询是否支持自动识别人脸位置。
     */
    private void isCameraAutoFocusFaceModeSupported(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.success(trtcCloud.isCameraAutoFocusFaceModeSupported());
    }

    /**
     * 添加水印
     */
    private void setWatermark(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String image = TencentRtcPluginUtil.getParam(call, result, "image");
        int streamType = TencentRtcPluginUtil.getParam(call, result, "streamType");
        float x = TencentRtcPluginUtil.getParam(call, result, "x");
        float y = TencentRtcPluginUtil.getParam(call, result, "y");
        float width = TencentRtcPluginUtil.getParam(call, result, "width");
        trtcCloud.setWatermark(BitmapFactory.decodeFile(image), streamType, x, y, width);
        result.success(null);
    }

    /**
     * 停止屏幕采集。IOS仅支持 IOS11及以上。
     */
    private void stopScreenCapture(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.stopScreenCapture();
        result.success(null);
    }

    /**
     * 暂停屏幕分享。IOS仅支持 IOS11及以上。
     */
    private void pauseScreenCapture(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.pauseScreenCapture();
        result.success(null);
    }

    /**
     * 恢复屏幕分享。IOS仅支持 IOS11及以上。
     */
    private void resumeScreenCapture(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.resumeScreenCapture();
        result.success(null);
    }

    /**
     * 停止远端辅流显示
     */
    private void stopRemoteSubStreamView(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        trtcCloud.stopRemoteSubStreamView(userId);
        result.success(null);
    }

    /**
     * 设置屏幕分享画面的显示模式。
     */
    private void setRemoteSubStreamViewFillMode(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        int mode = TencentRtcPluginUtil.getParam(call, result, "mode");
        trtcCloud.setRemoteSubStreamViewFillMode(userId, mode);
        result.success(null);
    }

    /**
     * 设置屏幕分享画面的顺时针旋转角度。
     */
    private void setRemoteSubStreamViewRotation(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        int rotation = TencentRtcPluginUtil.getParam(call, result, "rotation");
        trtcCloud.setRemoteSubStreamViewRotation(userId, rotation);
        result.success(null);
    }

    /**
     * 发送自定义消息给房间内所有用户。
     */
    private void sendCustomCmdMsg(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int cmdId = TencentRtcPluginUtil.getParam(call, result, "cmdID");
        byte[] data = TencentRtcPluginUtil.getParam(call, result, "data");
        boolean reliable = TencentRtcPluginUtil.getParam(call, result, "reliable");
        boolean ordered = TencentRtcPluginUtil.getParam(call, result, "ordered");
        trtcCloud.sendCustomCmdMsg(cmdId, data, reliable, ordered);
        result.success(null);
    }

    /**
     * 将小数据量的自定义数据嵌入视频帧中。
     */
    private void sendSEIMsg(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String data = TencentRtcPluginUtil.getParam(call, result, "data");
        int repeatCount = TencentRtcPluginUtil.getParam(call, result, "repeatCount");
        trtcCloud.sendSEIMsg(data.getBytes(), repeatCount);
        result.success(null);
    }

    /**
     * 开始进行网络测速（视频通话期间请勿测试，以免影响通话质量）。
     */
    private void startSpeedTest(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int appid = TencentRtcPluginUtil.getParam(call, result, "appid");
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        String userSig = TencentRtcPluginUtil.getParam(call, result, "userSig");
        trtcCloud.startSpeedTest(appid, userId, userSig);
        result.success(null);
    }

    /**
     * 停止服务器测速
     */
    private void stopSpeedTest(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        trtcCloud.stopSpeedTest();
        result.success(null);
    }

    /**
     * 获得SDK版本
     */
    private void getSDKVersion(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        result.success(TRTCCloud.getSDKVersion());
    }

    /**
     * 设置日志输出级别
     */
    private void setLogLevel(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        int level = TencentRtcPluginUtil.getParam(call, result, "level");
        TRTCCloud.setLogLevel(level);
        result.success(null);
    }

    /**
     * 启用或禁用 Log 的本地压缩。
     */
    private void setLogCompressEnabled(@NonNull MethodCall call, @NonNull Result result) {
        boolean enabled = TencentRtcPluginUtil.getParam(call, result, "enabled");
        TRTCCloud.setLogCompressEnabled(enabled);
        result.success(null);
    }

    /**
     * 修改日志保存路径。
     */
    private void setLogDirPath(@NonNull MethodCall call, @NonNull Result result) {
        String path = TencentRtcPluginUtil.getParam(call, result, "path");
        TRTCCloud.setLogDirPath(path);
        result.success(null);
    }

    /**
     * 设置仪表盘的边距。
     */
    private void setDebugViewMargin(@NonNull MethodCall call, @NonNull Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        float left = TencentRtcPluginUtil.getParam(call, result, "left");
        float right = TencentRtcPluginUtil.getParam(call, result, "right");
        float top = TencentRtcPluginUtil.getParam(call, result, "top");
        float bottom = TencentRtcPluginUtil.getParam(call, result, "bottom");
        trtcCloud.setDebugViewMargin(userId, new TRTCCloud.TRTCViewMargin(left, right, top, bottom));
        result.success(null);
    }

    /**
     * 生成用户签名。
     */
    private void genUserSig(@NonNull MethodCall call, @NonNull Result result) {
        int appid = TencentRtcPluginUtil.getParam(call, result, "appid");
        String secretkey = TencentRtcPluginUtil.getParam(call, result, "secretKey");
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        result.success(GenerateTestUserSig.genTestUserSig(appid, secretkey, userId));
    }
}