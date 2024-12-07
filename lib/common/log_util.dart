import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

/// 日志工具类
class LogUtil {
  /// 是否启用日志
  static bool _enableLog = true;

  /// 日志标签
  static const String _tag = "Flutter";

  /// 是否显示日志调用栈
  static bool _showStack = true;

  /// 初始化日志工具
  static void init({bool enableLog = true, bool showStack = true}) {
    _enableLog = enableLog;
    _showStack = showStack;
  }

  /// 输出debug级别日志
  static void d(dynamic msg, {String tag = _tag}) {
    if (!_enableLog) return;
    _printLog(msg, tag: tag, level: 'DEBUG');
  }

  /// 输出info级别日志
  static void i(dynamic msg, {String tag = _tag}) {
    if (!_enableLog) return;
    _printLog(msg, tag: tag, level: 'INFO');
  }

  /// 输出warning级别日志
  static void w(dynamic msg, {String tag = _tag}) {
    if (!_enableLog) return;
    _printLog(msg, tag: tag, level: 'WARN');
  }

  /// 输出error级别日志
  static void e(dynamic msg, {String tag = _tag, bool withStack = true}) {
    if (!_enableLog) return;
    _printLog(msg, tag: tag, level: 'ERROR', withStack: withStack);
  }

  /// 内部打印日志的方法
  static void _printLog(
    dynamic msg, {
    required String tag,
    required String level,
    bool withStack = false,
  }) {
    if (!_enableLog) return;

    // 获取调用栈信息
    String stackTrace = '';
    if (_showStack || withStack) {
      stackTrace = _getStackTrace();
    }

    // 构建日志内容
    String content = '[$tag] $level: $msg';
    if (stackTrace.isNotEmpty) {
      content += '\n$stackTrace';
    }

    // 在debug模式下打印日志
    if (kDebugMode) {
      print(content);
    }
  }

  /// 获取调用栈信息
  static String _getStackTrace() {
    Trace trace = Trace.current();
    // 跳过前3帧（当前方法、_printLog方法和具体的日志方法）
    var frames = trace.frames.skip(3).take(3);
    return frames
        .map((frame) => '  at ${frame.member} (${frame.location})')
        .join('\n');
  }

  /// 打印分割线
  static void divider([String char = '-']) {
    if (!_enableLog) return;
    print(char * 80);
  }
}
