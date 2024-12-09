import 'package:ai_music/modules/home/bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 路由助手类
class RouteHelper {
  /// 导航到指定页面
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// 替换当前页面
  static Future<T?> replace<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }

  /// 移除所有页面，并导航到指定页面
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    bool keepPreviousPages = false,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => keepPreviousPages,
      arguments: arguments,
    );
  }

  /// 返回上一页
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  /// 返回到指定页面
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  /// 获取路由参数
  static T? arguments<T>(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments as T?;
  }

  /// 切换到首页指定tab
  static void switchHomeTab(BuildContext context, int index) {
    context.read<HomePageBloc>().add(HomeSwitchTabEvent(index));
  }
}
