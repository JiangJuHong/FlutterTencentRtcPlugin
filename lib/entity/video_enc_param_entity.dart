class VideoEncParamEntity {
  int videoBitrate;
  int videoResolution;
  int videoResolutionMode;
  int videoFps;

  VideoEncParamEntity(
      {this.videoBitrate,
      this.videoResolution,
      this.videoResolutionMode,
      this.videoFps});

  VideoEncParamEntity.fromJson(Map<String, dynamic> json) {
    videoBitrate = json['videoBitrate'];
    videoResolution = json['videoResolution'];
    videoResolutionMode = json['videoResolutionMode'];
    videoFps = json['videoFps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoBitrate'] = this.videoBitrate;
    data['videoResolution'] = this.videoResolution;
    data['videoResolutionMode'] = this.videoResolutionMode;
    data['videoFps'] = this.videoFps;
    return data;
  }
}
