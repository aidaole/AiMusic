import 'package:ai_music/routes/route_helper.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';

import '../../network/dio_utils.dart';
import '../../routes/app_routes.dart';
import '../../themes/theme_size.dart';
import '../../widgets/common_button.dart';

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
            "未注册的手机号验证通过后将自动创建账号",
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
          // 临时测试按钮,用于跳转到验证码页面
          _buildJumpVerifyCodePage(context),
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
      controller: _phoneInputController..text = '13880553414',
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
      child: CommonButton(
        text: '获取短信验证码',
        onPressed: () async {
          // 获取短信验证码
          final phone = _phoneInputController.text;
          final response =
              await DioUtils.get(path: '/captcha/sent?phone=$phone');

          // 如果请求成功且状态码为200,跳转到验证码输入页面
          if (response != null && response['code'] == 200) {
            RouteHelper.push(
              context,
              AppRoutes.smsVerifyCode,
              arguments: phone,
            );
          }
        },
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

  _buildJumpVerifyCodePage(BuildContext context) {
    return CommonButton(
      text: '验证短信验证码(测试)',
      onPressed: () {
        final phone = _phoneInputController.text;
        RouteHelper.push(
          context,
          AppRoutes.smsVerifyCode,
          arguments: phone,
        );
      },
    );
  }
}
