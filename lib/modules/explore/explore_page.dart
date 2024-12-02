import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: defaultBgColor,
      child: const Center(
          child: Text("ExplorePage", style: TextStyle(color: Colors.white))),
    );
  }
}
