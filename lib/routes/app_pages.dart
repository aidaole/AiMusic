import 'package:flutter/material.dart';

import '../modules/home/home_page.dart';
import '../modules/login/sms_code_login_page.dart';
import '../modules/login/sms_verify_phone_code_page.dart';
import 'app_routes.dart';
// 导入其他页面

/// 页面路由配置
class AppPages {
  /// 初始路由
  static const initial = AppRoutes.home;

  /// 路由页面配置
  static final routes = <String, WidgetBuilder>{
    // 主页模块
    AppRoutes.home: (context) => const HomePage(),
    // 登录模块
    AppRoutes.smsLogin: (context) => SmsCodeLoginPage(),
    AppRoutes.smsVerifyCode: (context) => const SmsVerifyPhoneCodePage(),
  };

  /// 404页面
  static final unknownRoute = MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(title: const Text('页面不存在')),
      body: const Center(child: Text('404')),
    ),
  );
}
