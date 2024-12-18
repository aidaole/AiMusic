import 'package:ai_music/widgets/common_button.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../routes/route_helper.dart';

class AccountNotLoginPage extends StatelessWidget {
  const AccountNotLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatusBarPlaceHolder(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "您还未登录",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 40,
                ),
                CommonButton(
                  text: "去登录",
                  onPressed: () {
                    RouteHelper.push(context, AppRoutes.phonePasswordLogin);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
