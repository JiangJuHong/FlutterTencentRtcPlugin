import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_video_view.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';
import 'package:tencent_rtc_plugin/enums/listener_type_enum.dart';
import 'package:tencent_rtc_plugin/controller/tencent_rtc_video_view_controller.dart';

/// 视频页面
class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  /// 在线用户列表
  Map<String, TencentRtcVideoViewController> olUser = {};

  @override
  initState() {
    super.initState();
    TencentRtcPlugin.addListener((type, param) {
      // 用户上传视频监听
      if (type == ListenerTypeEnum.UserVideoAvailable) {
        Map<String, dynamic> paramObj = jsonDecode(param);
        String userId = paramObj["userId"];
        // 根据状态对视频进行开启和关闭
        if (paramObj["available"]) {
          olUser[userId] = null;
        } else {
          TencentRtcVideoViewController controller = olUser[userId];
          if (controller != null) {
            controller.stopRemoteView(userId: userId);
          }
          olUser.remove(userId);
        }

        this.setState((){});
      }
    });
  }

  /// 创建事件
  onViewCreated(id, controller) {
    if (olUser[id] == null) {
      olUser[id] = controller;
      controller.startRemoteView(userId: id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("视频界面"),
      ),
      body: ListView(
        children: olUser.keys
            .map(
              (id) => Container(
                color: Colors.red,
//                height: MediaQuery.of(context).size.height / 2,
                height: 200,
                child: TencentRtcVideoView(
                  onViewCreated: (controller) => onViewCreated(id, controller),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
