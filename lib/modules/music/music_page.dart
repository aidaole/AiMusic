import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: defaultBgColor,
      child: const Center(
          child: Text("MusicPage", style: TextStyle(color: Colors.white))),
    );
  }
}
