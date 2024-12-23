import 'package:flutter/material.dart';

class RadiusContainer extends StatelessWidget {
  final double radius;
  final double width;
  final double height;
  final Widget child;

  const RadiusContainer({
    super.key,
    required this.radius,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
