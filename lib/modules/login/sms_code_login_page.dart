import 'package:ai_music/modules/account/bloc/account_bloc.dart';
import 'package:ai_music/modules/account/bloc/account_event.dart';
import 'package:ai_music/routes/route_helper.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routes/app_routes.dart';
import '../../themes/theme_size.dart';
import '../../widgets/common_button.dart';
import '../account/bloc/account_state.dart';

class SmsCodeLoginPage extends StatelessWidget {
  SmsCodeLoginPage({super.key});

  final TextEditingController _phoneInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatusBarPlaceHolder(),
          _buildActionBar(context),
          const SizedBox(
            height: 20,
          ),
          Text(
            "登录网易账号",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "手机号验证已失效, 可以获取验证码, 但是登录会失败, 请使用二维码登录",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white.withAlpha(80)),
          ),
          const SizedBox(
            height: 40,
          ),
          _buildPhoneInputWidget(),
          const SizedBox(
            height: 40,
          ),
          _buildGetSmsCodeButton(context),
          const SizedBox(
            height: 20,
          ),
          CommonButton(
            text: '二维码登录',
            onPressed: () async {
              RouteHelper.push(context, AppRoutes.qrLogin);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _buildUserAgreementWidget(),
        ],
      ),
    );
  }

  _buildActionBar(BuildContext context) {
    return SizedBox(
      height: defaultActionBarHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  _buildPhoneInputWidget() {
    return TextField(
      controller: _phoneInputController..text = '',
      style: const TextStyle(color: Colors.white, fontSize: 20),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: '请输入手机号',
        hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  _buildGetSmsCodeButton(BuildContext context) {
    return SizedBox(
        width: double.infinity, // 按钮宽度占满父容器
        height: 50, // 设置按钮高度
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is GetSmsCodeSuccess) {
              RouteHelper.push(
                context,
                AppRoutes.smsVerifyCode,
                arguments: state.phone,
              );
            } else if (state is GetSmsCodeFailed) {
              showToast("获取短信验证码失败");
            }
          },
          child: CommonButton(
            text: '获取短信验证码',
            onPressed: () async {
              context
                  .read<AccountBloc>()
                  .add(GetSmsCodeEvent(phone: _phoneInputController.text));
            },
          ),
        ));
  }

  _buildUserAgreementWidget() {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        const Expanded(
          child: Text(
            "我已阅读并同意用户协议, 并授权获取短信验证码",
          ),
        ),
      ],
    );
  }

  void showToast(String s) {
    Fluttertoast.showToast(msg: s);
  }
}
