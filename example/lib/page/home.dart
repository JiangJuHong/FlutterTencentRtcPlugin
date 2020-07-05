import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';
import 'package:tencent_rtc_plugin/enums/listener_type_enum.dart';
import 'package:tencent_rtc_plugin_example/page/video.dart';

class HomePage extends StatefulWidget {
  //for testing perpose
  //read from env variable
  //defined by flutter run --dart-define=APP_ID=12345
  static const int APP_ID = int.fromEnvironment("APP_ID");
  static const String USER_ID = String.fromEnvironment("USER_ID");
  static const String USER_SIG = String.fromEnvironment("USER_SIG");

  HomePage({Key key}) : super(key: key);

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
        print(param);
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new VideoPage()),
        );
      }
    });
  }

  // 进入房间(加入或创建)
  onEnterRoom() {
    TencentRtcPlugin.enterRoom(
      appid: HomePage.APP_ID,
      userId: HomePage.USER_ID,
      userSig: HomePage.USER_SIG,
      roomId: int.parse(controller.text),
      scene: 0,
    );
    controller.clear();
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
