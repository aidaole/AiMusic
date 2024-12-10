import 'package:flutter/material.dart';

class LoadErrorWidget extends StatelessWidget {
  const LoadErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "加载失败",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
