import 'package:flutter/material.dart';

import 'page/home.dart';
import 'page/multi-video.dart';
import 'page/room.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => HomePage(),
        "/multi-video": (context) => MultiVideo(),
        "/room": (context) => Room(),
      },
    );
  }
}
