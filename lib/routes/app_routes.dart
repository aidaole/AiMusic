/// 路由名称常量
abstract class AppRoutes {
  // 登录相关
  static const login = '/login';
  static const smsLogin = '/login/sms_login';
  static const smsVerifyCode = '/login/sms_verify_code';

  // 主页相关
  static const home = '/home';
  static const discover = '/home/discover';
  static const profile = '/home/profile';

  // 播放相关
  static const player = '/player';
  static const playlist = '/playlist';

  // 设置相关
  static const settings = '/settings';
  static const theme = '/settings/theme';
}
