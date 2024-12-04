import 'dart:async';
import 'package:ai_music/network/dio_utils.dart';
import 'package:ai_music/themes/theme_color.dart';
import 'package:ai_music/widgets/status_bar_playce_holder.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrLoginPage extends StatefulWidget {
  const QrLoginPage({super.key});

  @override
  State<QrLoginPage> createState() => _QrLoginPageState();
}

class _QrLoginPageState extends State<QrLoginPage> {
  String? _qrUrl;
  String? _qrKey;
  Timer? _checkTimer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initQrLogin();
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  // 初始化二维码登录
  Future<void> _initQrLogin() async {
    try {
      // 1. 获取key
      final keyResponse = await DioUtils.get(path: '/login/qr/key');
      if (keyResponse != null && keyResponse['code'] == 200) {
        _qrKey = keyResponse['data']['unikey'];

        // 2. 获取二维码
        final qrResponse = await DioUtils.get(
          path: '/login/qr/create',
          queryParameters: {'key': _qrKey, 'qrimg': true},
        );

        if (qrResponse != null && qrResponse['code'] == 200) {
          setState(() {
            _qrUrl = qrResponse['data']['qrurl'];
            _isLoading = false;
          });

          // 3. 开始轮询检查状态
          _startCheckingQrStatus();
        }
      }
    } catch (e) {
      debugPrint('初始化二维码登录失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 开始检查二维码状态
  void _startCheckingQrStatus() {
    _checkTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_qrKey == null) return;

      try {
        final response = await DioUtils.get(
          path: '/login/qr/check',
          queryParameters: {'key': _qrKey},
        );

        if (response != null) {
          switch (response['code']) {
            case 800:
              // 二维码过期，需要刷新
              _showMessage('二维码已过期，请刷新');
              timer.cancel();
              break;
            case 801:
              // 等待扫码
              break;
            case 802:
              // 待确认
              _showMessage('请在手机上确认登录');
              break;
            case 803:
              // 登录成功
              _showMessage('登录成功');
              timer.cancel();
              if (mounted) {
                Navigator.of(context).pop();
              }
              break;
          }
        }
      } catch (e) {
        debugPrint('检查二维码状态失败: $e');
      }
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
          const SizedBox(height: 20),
          Text(
            "登录网易账号",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            "请使用登录了网易账号的网易云音乐App扫码",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white.withAlpha(80)),
          ),
          const SizedBox(height: 40),
          // 二维码显示区域
          _buildQrCodeWidget(),
        ],
      ),
    );
  }

  Widget _buildQrCodeWidget() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_qrUrl == null) {
      return Center(
        child: Column(
          children: [
            const Text('获取二维码失败'),
            ElevatedButton(
              onPressed: _initQrLogin,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: QrImageView(
          data: _qrUrl!,
          version: QrVersions.auto,
          size: 180,
        ),
      ),
    );
  }

  _buildActionBar(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
          const Spacer(),
          // 添加刷新按钮
          IconButton(
            onPressed: _initQrLogin,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
