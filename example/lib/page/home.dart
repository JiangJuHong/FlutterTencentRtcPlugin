import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';
import 'package:tencent_rtc_plugin/enums/listener_type_enum.dart';
import 'package:tencent_rtc_plugin_example/page/video.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    TencentRtcPlugin.addListener((type, param) {
      if (type == ListenerTypeEnum.EnterRoom) {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new VideoPage()),
        );
      }
    });
  }

  /// 进入房间(加入或创建)
  onEnterRoom() {
    TencentRtcPlugin.enterRoom(
      appid: 1400290273,
      userId: "123",
      userSig:
          "eJwtzMEKgkAUheF3ueuQO3ccTaFNYBCZELlxWc0YN1OG0SSL3j1Rl*c78H8hT89ebxzEQB7CatqsTdNxyRMLkgu3urpYyxpi4SNShBTK*TFvy86MrpQiRJy143qyNUkfRUBLhe9jdUevY5E8XWjaD-d5aDMdJTnzIYuCIXXN-jpU9eOE21uxgd8fXgowjA__",
      roomId: int.parse(controller.text),
      scene: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: "房间ID"),
              ),
            ),
            RaisedButton(
              onPressed: onEnterRoom,
              child: Text("加入房间"),
            ),
          ],
        ),
      ),
    );
  }
}
