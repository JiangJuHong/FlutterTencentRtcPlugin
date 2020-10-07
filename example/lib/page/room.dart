import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';
import 'package:tencent_rtc_plugin/enums/route_enum.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_video_view.dart';
import 'package:tencent_rtc_plugin/controller/tencent_rtc_video_view_controller.dart';
import 'package:tencent_rtc_plugin/enums/listener_type_enum.dart';
import 'package:tencent_rtc_plugin/entity/user_available_entity.dart';

/// 房间
class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 房间号
  int _room;

  /// 当前登录用户名
  String _name;

  /// 是否启用摄像头
  bool _enabledCamera;

  /// 是否启用麦克风
  bool _enabledMicrophone;

  /// 当前是否是前置摄像头
  bool _frontCamera = false;

  /// 当前是否是扬声器
  bool _speaker = true;

  /// 用户ID列表
  Map<String, TencentRtcVideoViewController> _users = {};

  @override
  void initState() {
    super.initState();
    TencentRtcPlugin.addListener(_rtcListener);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Map arguments = ModalRoute.of(_scaffoldKey.currentContext).settings.arguments;
      _room = arguments["room"];
      _name = arguments["name"];
      _enabledCamera = arguments["enabledCamera"];
      _enabledMicrophone = arguments["enabledMicrophone"];
      _users[_name] = null;
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    TencentRtcPlugin.removeListener(_rtcListener);
    TencentRtcPlugin.exitRoom();
  }

  /// 腾讯云RTC监听器
  _rtcListener(type, params) {
    if (type == ListenerTypeEnum.Log) {
      return;
    }

    if (type == ListenerTypeEnum.UserVideoAvailable) {
      UserAvailableEntity data = params;
      if (data.available && !_users.containsKey(data.userId)) {
        _users[data.userId] = null;
      }

      if (!data.available) {
        _users.remove(data.userId);
      }

      this.setState(() {});
    }
  }

  /// 退出按钮点击事件
  _onExitClick() {
    Navigator.pop(context);
  }

  /// 切换相机按钮点击事件
  _onChangeCameraClick() {
    TencentRtcPlugin.switchCamera();
    this.setState(() => _frontCamera = !_frontCamera);
  }

  /// 切换扬声器按钮点击事件
  _onChangeSpeakerClick() {
    TencentRtcPlugin.setAudioRoute(route: _speaker ? RouteEnum.Earpiece : RouteEnum.Speaker);
    this.setState(() => _speaker = !_speaker);
  }

  /// 获得视图大小
  /// [index] 第几个视图
  /// [total] 总共多少个视图
  Size _getViewSize(int index, int total) {
    Size screenSize = MediaQuery.of(context).size;

    // 只有一个显示全屏
    if (total == 1) {
      return screenSize;
    }

    // 两个或则只有三个但是是第一个时就显示半屏
    if (total == 2 || (index == 0 && total == 3)) {
      return Size(screenSize.width, screenSize.height / 2);
    }

    // 小于等于四个显示四分之一屏
    if (total <= 4) {
      return Size(screenSize.width / 2, screenSize.height / 2);
    }
    return Size(screenSize.width / 4, (screenSize.width / 4) * (16 / 9));
  }

  /// 根据用户ID获得控制器
  TencentRtcVideoViewController _getUserController(String userId) {
    for (var u in this._users.keys.toList()) {
      if (userId == u) return this._users[u];
    }
    return null;
  }

  /// 相机按钮点击
  _onCameraClick() async {
    if (_enabledCamera) {
      await TencentRtcPlugin.stopLocalPreview();
    } else {
      await this._getUserController(_name).startLocalPreview(frontCamera: _frontCamera);
    }
    this.setState(() => _enabledCamera = !_enabledCamera);
  }

  /// 麦克风按钮点击
  _onMicrophoneClick() async {
    if (_enabledMicrophone) {
      await TencentRtcPlugin.stopLocalAudio();
    } else {
      await TencentRtcPlugin.startLocalAudio();
    }
    this.setState(() => _enabledMicrophone = !_enabledMicrophone);
  }

  /// 用户列表点击事件
  _onUserListClick() {
    showModalBottomSheet(
      builder: (BuildContext context) {
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: _users.keys
                .map(
                  (e) => ListTile(
                    title: Text(e),
                  ),
                )
                .toList(),
          ).toList(),
        );
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.indigoAccent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Wrap(
              children: List.generate(
                _users.keys.length,
                (index) => LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  Size size = this._getViewSize(index, _users.length);
                  return Container(
                    height: size.height,
                    width: size.width,
                    child: TencentRtcVideoView(
                      onViewCreated: (controller) {
                        String key = _users.keys.toList()[index];
                        _users[key] = controller;
                        if (key == _name) {
                          if (_enabledCamera) controller.startLocalPreview(frontCamera: _frontCamera);
                          if (_enabledMicrophone) TencentRtcPlugin.startLocalAudio();
                        } else {
                          controller.startRemoteView(userId: key);
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 20, right: 20, bottom: MediaQuery.of(context).padding.bottom),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  _speaker ? Icons.volume_up : Icons.hearing,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: _onChangeSpeakerClick,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.flip_camera_ios,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                onPressed: _onChangeCameraClick,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${_room ?? "加载中..."}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                onPressed: _onExitClick,
                                color: Colors.redAccent,
                                child: Text("退出会议", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Icon(
                        Icons.signal_cellular_alt,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${_name ?? "加载中"}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        {"icon": _enabledMicrophone != null && _enabledMicrophone ? Icons.mic : Icons.mic_off, "onTap": _onMicrophoneClick},
                        {"icon": _enabledCamera != null && _enabledCamera ? Icons.videocam : Icons.videocam_off, "onTap": _onCameraClick},
                        {"icon": Icons.people, "onTap": _onUserListClick},
                        {"icon": Icons.more_horiz},
                      ]
                          .map(
                            (e) => Expanded(
                              child: IconButton(
                                icon: Icon(
                                  e["icon"],
                                  color: Colors.white,
                                ),
                                onPressed: e["onTap"],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
