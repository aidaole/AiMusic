import 'package:ai_music/common/log_util.dart';
import 'package:ai_music/widgets/common_button.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes/app_routes.dart';
import '../../routes/route_helper.dart';
import '../account/bloc/account_bloc.dart';
import '../account/bloc/account_event.dart';
import '../account/bloc/account_state.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const StatusBarPlaceHolder(),
            _buildActionBar(context),
            const Spacer(),
            _buildLogoutBtn(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<AccountBloc, AccountState> _buildLogoutBtn() {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          RouteHelper.popUntil(context, AppRoutes.home);
          context.read<AccountBloc>().add(FetchAccountInfo());
        }
        if (state is LogoutFailed) {
          LogUtil.e('退出登录失败');
        }
      },
      builder: (context, state) {
        if (state is AccountSuccess) {
          return CommonButton(
            text: '退出登录',
            onPressed: () {
              context.read<AccountBloc>().add(LogoutEvent());
            },
          );
        }
        return Container();
      },
    );
  }

  _buildActionBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              RouteHelper.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ],
    );
  }
}
