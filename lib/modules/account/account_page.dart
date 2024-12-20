import 'package:ai_music/modules/account/account_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/common_circle_loading.dart';
import '../../modules/account/bloc/account_bloc.dart';
import '../../modules/account/bloc/account_state.dart';
import '../../themes/theme_color.dart';
import 'account_not_login_page.dart';
import 'bloc/account_event.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(FetchAccountInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: BlocBuilder<AccountBloc, AccountState>(
        buildWhen: (previous, current) {
          return current is AccountSuccess ||
              current is AccountError ||
              current is AccountLoading;
        },
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CommonCircleLoading());
          }
          if (state is AccountError) {
            return const AccountNotLoginPage();
          }
          if (state is AccountSuccess) {
            return AccountInfoPage(account: state.account);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
