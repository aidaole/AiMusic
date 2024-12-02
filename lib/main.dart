import 'package:ai_music/app.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: defaultBgColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: defaultBgColor,
        systemNavigationBarIconBrightness: Brightness.light),
  );
  runApp(const App());
}
