package top.huic.tencent_rtc_plugin;

import android.content.Context;
import android.util.Log;

import com.tencent.trtc.TRTCCloud;
import com.tencent.trtc.TRTCCloudDef;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.platform.PlatformViewRegistry;
import top.huic.tencent_rtc_plugin.listener.CustomTRTCCloudListener;
import top.huic.tencent_rtc_plugin.util.TencentRtcPluginUtil;
import top.huic.tencent_rtc_plugin.view.TencentRtcVideoPlatformView;

/**
 * TencentRtcPlugin
 */
public class TencentRtcPlugin implements FlutterPlugin, MethodCallHandler {

    private final static String TAG = TencentRtcPlugin.class.getName();

    /**
     * 全局上下文
     */
    private Context context;

    /**
     * 腾讯云音视频通信实例
     */
    private TRTCCloud trtcCloud;

    public TencentRtcPlugin() {
    }

    private TencentRtcPlugin(BinaryMessenger messenger, Context context, MethodChannel channel, PlatformViewRegistry registry) {
        this.context = context;
        // 初始化实例
        trtcCloud = TRTCCloud.sharedInstance(this.context);
        trtcCloud.setListener(new CustomTRTCCloudListener(context, channel));

        // 注册View
        registry.registerViewFactory(TencentRtcVideoPlatformView.SIGN, new TencentRtcVideoPlatformView(context, messenger));
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "tencent_rtc_plugin");
        channel.setMethodCallHandler(new TencentRtcPlugin(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext(), channel, flutterPluginBinding.getPlatformViewRegistry()));
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
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "tencent_rtc_plugin");
        channel.setMethodCallHandler(new TencentRtcPlugin(registrar.messenger(), registrar.context(), channel, registrar.platformViewRegistry()));
    }

    public Context getContext() {
        return context;
    }

    public TRTCCloud getTrtcCloud() {
        return trtcCloud;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        Log.d(TAG, "调用方法: " + call.method);
        switch (call.method) {
            case "enterRoom":
                this.enterRoom(call, result);
                break;
            case "muteRemoteAudio":
                this.muteRemoteAudio(call, result);
                break;
            case "muteAllRemoteAudio":
                this.muteAllRemoteAudio(call, result);
                break;
            case "setRemoteViewFillMode":
                this.setRemoteViewFillMode(call, result);
                break;
            default:
                result.notImplemented();
        }

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
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
        trtcCloud.enterRoom(trtcParams, scene);
    }

    /**
     * 静音 / 取消静音
     */
    private void muteRemoteAudio(@NonNull MethodCall call, @NonNull Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteRemoteAudio(userId, mute);
    }

    /**
     * 静音 / 取消静音 所有用户
     */
    private void muteAllRemoteAudio(@NonNull MethodCall call, @NonNull Result result) {
        boolean mute = TencentRtcPluginUtil.getParam(call, result, "mute");
        trtcCloud.muteAllRemoteAudio(mute);
    }

    /**
     * 设置远程显示填充模式
     */
    private void setRemoteViewFillMode(@NonNull MethodCall call, @NonNull Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        int mode = TencentRtcPluginUtil.getParam(call, result, "mode");
        trtcCloud.setRemoteViewFillMode(userId, mode);
    }
}