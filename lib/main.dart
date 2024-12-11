import 'package:ai_music/common/log_util.dart';
import 'package:ai_music/network/dio_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'themes/theme_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LogUtil.init(
    enableLog: true,
    showStack: false,
  );
  try {
    await DioUtils.init();
    logi('Dio初始化成功');
  } catch (e) {
    loge('Dio初始化失败: $e');
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: defaultBgColor,
        systemNavigationBarIconBrightness: Brightness.light),
  );
  runApp(const App());
}
