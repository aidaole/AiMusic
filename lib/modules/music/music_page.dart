import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildStatusBar(context),
        _buildActionBar(context),
      ],
    );
  }

  _buildStatusBar(BuildContext context) {
    return SizedBox(height: defaultStatusBarHeight.toDouble());
  }

  _buildActionBar(BuildContext context) {
    const iconSize = 25.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: defaultActionBarHeight.toDouble(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.menu, size: iconSize)),
            Text(
              "模式选择",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            const Icon(Icons.search, size: iconSize),
          ],
        ),
      ),
    );
  }
}
