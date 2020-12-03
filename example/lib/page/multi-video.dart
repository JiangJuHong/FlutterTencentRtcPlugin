import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_rtc_plugin/enums/quality_enum.dart';
import 'package:tencent_rtc_plugin/enums/resolution_enum.dart';
import 'package:tencent_rtc_plugin/enums/resolution_mode_enum.dart';
import 'package:tencent_rtc_plugin/entity/video_enc_param_entity.dart';
import 'package:tencent_rtc_plugin/enums/scene_enum.dart';
import 'package:tencent_rtc_plugin/enums/listener_type_enum.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';
import 'package:tencent_rtc_plugin_example/util/global.dart';

/// 多人视频会议电话
class MultiVideo extends StatefulWidget {
  @override
  _MultiVideoState createState() => _MultiVideoState();
}

class _MultiVideoState extends State<MultiVideo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 房间号
  int _room;

  /// 用户名
  String _user;

  /// 是否开启摄像头
  bool _enabledCamera = true;

  /// 是否开启麦克风
  bool _enabledMicrophone = true;

  /// 音质
  QualityEnum _quality = QualityEnum.Speech;

  @override
  void initState() {
    super.initState();
    TencentRtcPlugin.addListener(_rtcListener);
    TencentRtcPlugin.enableAudioVolumeEvaluation(intervalMs: 100);
  }

  @override
  void dispose() {
    super.dispose();
    TencentRtcPlugin.removeListener(_rtcListener);
  }

  /// 腾讯云RTC监听器
  _rtcListener(type, params) async {
    if (type == ListenerTypeEnum.EnterRoom) {
      if (params < 0) {
        _scaffoldKey.currentState
          ..showSnackBar(SnackBar(content: Text('进房失败!')));
        return;
      }

      if (await Permission.camera.request().isGranted &&
          await Permission.microphone.request().isGranted) {
        Navigator.pushNamed(context, "/room", arguments: {
          "room": _room,
          "name": _user,
          "enabledCamera": _enabledCamera,
          "enabledMicrophone": _enabledMicrophone,
        });
      }
    }
  }

  /// 进入房间按钮点击事件
  _onEnterRoom() async {
    if (_room == null) {
      _scaffoldKey.currentState
        ..showSnackBar(SnackBar(content: Text('会议号不能为空!')));
      return;
    }

    if (_user == null) {
      _scaffoldKey.currentState
        ..showSnackBar(SnackBar(content: Text('用户名不能为空!')));
      return;
    }

    String sign = await TencentRtcPlugin.genUserSig(
        appid: Global.appid, userId: _user, secretKey: Global.secretKey);
    TencentRtcPlugin.enterRoom(
        appid: Global.appid,
        userId: _user,
        userSig: sign,
        roomId: _room,
        scene: SceneEnum.VideoCall);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "多人视频会议",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blueGrey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "会议号",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(width: 20),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "请输入会议号",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) => this._room = int.parse(value),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1, color: Colors.grey),
                  Row(
                    children: [
                      Text(
                        "用户名",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(width: 20),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "请输入用户名",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) => this._user = value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("开启摄像头"),
                    trailing: Switch(
                      value: _enabledCamera,
                      onChanged: (value) =>
                          this.setState(() => _enabledCamera = value),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("开启麦克风"),
                    trailing: Switch(
                      value: _enabledMicrophone,
                      onChanged: (value) =>
                          this.setState(() => _enabledMicrophone = value),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("音质选择"),
                    subtitle: Row(
                      children: [
                        {"text": "语音", "value": QualityEnum.Speech},
                        {"text": "标准", "value": QualityEnum.Default},
                        {"text": "音乐", "value": QualityEnum.Music},
                      ]
                          .map(
                            (e) => Expanded(
                              child: Row(
                                children: [
                                  Radio(
                                    value: e["value"],
                                    groupValue: this._quality,
                                    onChanged: (value) => this
                                        .setState(() => this._quality = value),
                                  ),
                                  Text(e["text"]),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: _onEnterRoom,
                            child: Text(
                              "进入会议",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
