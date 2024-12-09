import 'package:flutter/material.dart';

/// 通用圆形加载控件
class CommonCircleLoading extends StatelessWidget {
  /// 加载控件大小
  final double size;

  /// 加载控件颜色
  final Color? color;

  /// 线条宽度
  final double strokeWidth;

  const CommonCircleLoading({
    super.key,
    this.size = 36.0,
    this.color = Colors.white,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
      ),
    );
  }
}
