import 'package:flutter/material.dart';

import '../themes/theme_size.dart';

class StatusBarPlaceHolder extends StatelessWidget {
  const StatusBarPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: defaultStatusBarHeight,
    );
  }
}
