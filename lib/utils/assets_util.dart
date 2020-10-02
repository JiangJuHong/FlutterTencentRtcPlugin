import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// 资源工具类
class AssetsUtil {
  /// 将资源复制到本地
  /// [asset]  Flutter资源
  /// [rewrite] 当存在相同文件的，是否覆盖
  /// [Return] Copy后的本地资源路径
  static Future<String> copyAssetToLocal(String asset, {bool rewrite: false}) async {
    int lastIndex = asset.lastIndexOf("/");

    // 初始化目录
    final dir = await getApplicationDocumentsDirectory();
    Directory rootDir = new Directory("${dir.path}${lastIndex != -1 ? "/${asset.substring(0, lastIndex)}" : ""}");
    if (!(await rootDir.exists())) {
      await rootDir.create(recursive: true);
    }

    // 初始化文件
    final file = new File("${rootDir.path}${lastIndex == -1 ? asset : asset.substring(lastIndex)}");
    if (await file.exists() && rewrite) {
      file.deleteSync();
    }

    if (!(await file.exists())) {
      final soundData = await rootBundle.load(asset);
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }

    return file.path;
  }
}
