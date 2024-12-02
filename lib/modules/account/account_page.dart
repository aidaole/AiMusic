import 'package:ai_music/themes/theme_color.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: defaultBgColor,
      child: const Center(
          child: Text(
        "UserPage",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
