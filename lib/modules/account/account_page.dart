import 'package:ai_music/modules/account/account_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AccountError) {
            return const AccountNotLoginPage();
          }
          if (state is AccountLoaded) {
            return AccountInfoPage(account: state.account);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
