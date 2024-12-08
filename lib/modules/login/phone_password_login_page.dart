import 'package:ai_music/network/dio_utils.dart';
import 'package:ai_music/routes/route_helper.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../themes/theme_size.dart';
import '../../widgets/common_button.dart';

class PhonePasswordLoginPage extends StatelessWidget {
  PhonePasswordLoginPage({super.key});

  final TextEditingController _phoneInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();

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
            "密码登录目前已经失效了, 请使用二维码登录, 更安全, 避免输入用户名密码",
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
          _buildPasswordInputWidget(),
          const SizedBox(
            height: 40,
          ),
          _buildLoginButton(context),
          const SizedBox(
            height: 20,
          ),
          CommonButton(
              text: "扫码登录",
              onPressed: () {
                RouteHelper.push(context, AppRoutes.qrLogin);
              }),
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

  _buildPasswordInputWidget() {
    return TextField(
        controller: _passwordInputController..text = '',
        style: const TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true, // 添加这一行使密码显示为*号
        decoration: InputDecoration(
          hintText: '请输入密码',
          hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ));
  }

  _buildUserAgreementWidget() {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        const Expanded(child: Text("我已阅读并同意用户协议, 并授权获取短信验证码")),
      ],
    );
  }

  _buildLoginButton(BuildContext context) {
    return CommonButton(
      text: '登录',
      onPressed: () async {
        var phone = _phoneInputController.text;
        var password = _passwordInputController.text;
        final resp = await DioUtils.get(
            path: "/login/cellphone?&phone=$phone&password=$password");
        if (resp.statusCode == 200) {
          final data = resp.data;
          print(data);
        }
      },
    );
  }
}
