package top.huic.tencent_rtc_plugin.view;

import android.content.Context;
import android.util.Log;
import android.view.View;

import com.tencent.rtmp.ui.TXCloudVideoView;
import com.tencent.trtc.TRTCCloud;

import androidx.annotation.NonNull;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import top.huic.tencent_rtc_plugin.util.TencentRtcPluginUtil;

/**
 * 视频视图
 */
public class TencentRtcVideoPlatformView extends PlatformViewFactory
        implements PlatformView, MethodChannel.MethodCallHandler {

    /**
     * 全局标识
     */
    public static final String SIGN = "plugins.huic.top/tencentRtcVideoView";

    /**
     * 日志标签
     */
    private static final String TAG = TencentRtcVideoPlatformView.class.getName();

    /**
     * 消息器
     */
    private BinaryMessenger messenger;

    /**
     * 腾讯云音视频通信实例
     */
    private TRTCCloud trtcCloud;

    /**
     * 腾讯云视频视图
     */
    private TXCloudVideoView remoteView;

    /**
     * 初始化工厂信息，此处的域是 PlatformViewFactory
     */
    public TencentRtcVideoPlatformView(Context context, BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        trtcCloud = TRTCCloud.sharedInstance(context);
        remoteView = new TXCloudVideoView(context);
    }

    @Override
    public View getView() {
        return remoteView;
    }

    @Override
    public void dispose() {
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        // 每次实例化对象，保证界面上每一个组件的独立性(此处域是 PlatformView和MethodChannel.MethodCallHandler)
        TencentRtcVideoPlatformView view = new TencentRtcVideoPlatformView(context, messenger);
        new MethodChannel(messenger, SIGN + "_" + viewId).setMethodCallHandler(view);
        return view;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "startRemoteView":
                this.startRemoteView(call, result);
                break;
            case "stopRemoteView":
                this.stopRemoteView(call, result);
                break;
            case "startLocalPreview":
                this.startLocalPreview(call, result);
                break;
            case "stopLocalPreview":
                this.stopLocalPreview(call, result);
                break;
            case "startRemoteSubStreamView":
                this.startRemoteSubStreamView(call, result);
                break;
            case "stopRemoteSubStreamView":
                this.stopRemoteSubStreamView(call, result);
                break;
            default:
                result.notImplemented();
        }

    }

    /**
     * 开启远程显示
     */
    private void startRemoteView(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        trtcCloud.startRemoteView(userId, this.remoteView);
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
     * 开启本地视频采集
     */
    private void startLocalPreview(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        boolean frontCamera = TencentRtcPluginUtil.getParam(call, result, "frontCamera");
        trtcCloud.startLocalPreview(frontCamera, this.remoteView);
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
     * 开启远端辅流显示
     */
    private void startRemoteSubStreamView(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String userId = TencentRtcPluginUtil.getParam(call, result, "userId");
        trtcCloud.startRemoteSubStreamView(userId, this.remoteView);
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
}