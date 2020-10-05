import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';

/// 房间
class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  /// 房间号
  int _room;

  /// 当前登录用户名
  String _name;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Map arguments = ModalRoute.of(context).settings.arguments;
      _room = arguments["room"];
      _name = arguments["name"];
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    TencentRtcPlugin.exitRoom();
  }

  /// 退出按钮点击事件
  _onExitClick() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: MediaQuery.of(context).padding.top, bottom: MediaQuery.of(context).padding.bottom),
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
                            Icons.volume_up,
                            // Icons.hearing,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () {},
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
                  {"icon": Icons.mic},
                  // {"icon": Icons.mic_off},
                  {"icon": Icons.videocam},
                  // {"icon": Icons.videocam_off},
                  {"icon": Icons.people},
                  {"icon": Icons.more_horiz},
                ]
                    .map(
                      (e) => Expanded(
                        child: IconButton(
                          icon: Icon(
                            e["icon"],
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
