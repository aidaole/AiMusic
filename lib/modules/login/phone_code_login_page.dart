import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/StatusBarPlaceHolder.dart';
import 'package:flutter/material.dart';

import '../../themes/theme_size.dart';

class PhoneCodeLoginPage extends StatelessWidget {
  const PhoneCodeLoginPage({super.key});

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
            "未注册的手机号验证通过后将自动创建账号",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white.withAlpha(80)),
          ),
          const SizedBox(
            height: 40,
          ),
          _buildPhoneInputWidget(),
          const SizedBox(
            height: 40,
          ),
          _buildGetSmsCodeButton(),
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

  _buildGetSmsCodeButton() {
    return SizedBox(
      width: double.infinity, // 按钮宽度占满父容器
      height: 50, // 设置按钮高度
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // 按钮背景色为白色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 设置圆角半径
          ),
        ),
        child: const Text(
          '获取短信验证码',
          style: TextStyle(
            fontSize: 18,
            color: defaultBgColor, // 使用主题中定义的背景色作为文字颜色
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  _buildUserAgreementWidget() {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        const Text("我已阅读并同意用户协议, 并授权获取短信验证码"),
      ],
    );
  }
}
