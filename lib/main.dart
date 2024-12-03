import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'themes/theme_color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: defaultBgColor,
        systemNavigationBarIconBrightness: Brightness.light),
  );
  runApp(const App());
}
