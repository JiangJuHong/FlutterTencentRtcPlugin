import 'package:tencent_rtc_plugin/enums/resolution_enum.dart';
import 'package:tencent_rtc_plugin/enums/resolution_mode_enum.dart';

/// 参数信息参考: http://doc.qcloudtrtc.com/group__TRTCCloudDef__android.html#classcom_1_1tencent_1_1trtc_1_1TRTCCloudDef_1_1TRTCVideoEncParam
class VideoEncParamEntity {
  /// 目标视频码率，SDK 会按照目标码率进行编码，只有在网络不佳的情况下才会主动降低视频码率。
  int videoBitrate;

  /// 视频分辨率
  ResolutionEnum videoResolution;

  /// 分辨率模式
  ResolutionModeEnum videoResolutionMode;

  /// 视频采集帧率
  int videoFps;

  /// 最低视频码率，SDK 会在网络不佳的情况下主动降低视频码率，最低会降至 minVideoBitrate 所设定的数值。
  int minVideoBitrate;

  /// 是否允许调整分辨率
  bool enableAdjustRes;

  VideoEncParamEntity({
    this.videoBitrate,
    this.videoResolution,
    this.videoResolutionMode,
    this.videoFps,
    this.minVideoBitrate,
    this.enableAdjustRes,
  });

  VideoEncParamEntity.fromJson(Map<String, dynamic> json) {
    videoBitrate = json['videoBitrate'];
    videoResolution = json['videoResolution'];
    videoResolutionMode = json['videoResolutionMode'];
    videoFps = json['videoFps'];
    minVideoBitrate = json['minVideoBitrate'];
    enableAdjustRes = json['enableAdjustRes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoBitrate'] = this.videoBitrate;
    data['videoResolution'] = this.videoResolution == null
        ? null
        : ResolutionTool.toInt(this.videoResolution);
    data['videoResolutionMode'] = this.videoResolutionMode == null
        ? null
        : ResolutionModeTool.toInt(this.videoResolutionMode);
    data['videoFps'] = this.videoFps;
    data['minVideoBitrate'] = this.minVideoBitrate;
    data['enableAdjustRes'] = this.enableAdjustRes;
    return data;
  }
}
