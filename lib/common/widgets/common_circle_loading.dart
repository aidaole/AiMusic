import 'package:flutter/material.dart';

/// 通用圆形加载控件
class CommonCircleLoading extends StatelessWidget {
  /// 加载控件大小
  final double size;

  /// 加载控件颜色 
  final Color? color;

  /// 线条宽度
  final double strokeWidth;

  /// 加载文本
  final String? text;

  const CommonCircleLoading({
    super.key,
    this.size = 36.0,
    this.color = Colors.white,
    this.strokeWidth = 4.0,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.white),
          ),
        ),
        if (text != null) ...[
          const SizedBox(height: 8),
          Text(
            text!,
            style: TextStyle(color: color ?? Colors.white),
          ),
        ],
      ],
    );
  }
}
