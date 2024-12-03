import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "Item $index",
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
