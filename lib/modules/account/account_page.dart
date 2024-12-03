import 'package:ai_music/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: defaultBgColor,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Container(color: Colors.red.withAlpha(50)),
          ),
          const Center(
              child: Text(
            "UserPage",
            style: TextStyle(color: Colors.white),
          )),
        ],
      ),
    );
  }
}
