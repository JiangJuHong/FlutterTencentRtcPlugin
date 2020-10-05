import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_rtc_plugin/tencent_rtc_plugin.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Github开源地址点击
  _onGithubAddressClick() {
    Clipboard.setData(ClipboardData(text: 'https://github.com/JiangJuHong/FlutterTencentRtcPlugin'));
    _scaffoldKey.currentState..showSnackBar(SnackBar(content: Text('地址复制成功!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('腾讯云TRTC Flutter插件Demo演示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  {"name": "多人视频会议", "path": "/multi-video"},
                  {"name": "语音聊天室"},
                  {"name": "视频互动直播"},
                  {"name": "语音通话"},
                  {"name": "视频通话"}
                ]
                    .map(
                      (e) => GestureDetector(
                        onTap: () => e["path"] == null ? null : Navigator.pushNamed(context, e["path"]),
                        child: Container(
                          height: 100,
                          width: (MediaQuery.of(context).size.width / 2) - 60,
                          color: e["path"] == null ? Colors.grey : Colors.lightBlueAccent,
                          child: Center(child: Text(e["name"], style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: _onGithubAddressClick,
                child: Text(
                  "Link: https://github.com/JiangJuHong/FlutterTencentRtcPlugin",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Container(height: 10),
              Text("本APP用于展示 TRTC for Flutter 的各类功能", style: TextStyle(color: Colors.grey)),
              Container(height: 10),
              FutureBuilder<String>(
                future: TencentRtcPlugin.getSDKVersion(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // 请求已结束
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text("SDK 版本加载失败");
                    } else {
                      return Text("TRTC SDK Version: ${snapshot.data}", style: TextStyle(color: Colors.grey));
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              Container(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
