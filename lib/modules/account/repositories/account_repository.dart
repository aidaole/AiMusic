import '../../../common/log_util.dart';
import '../../../network/dio_utils.dart';
import '../models/account_model.dart';

class AccountRepository {
  Future<AccountModel> getAccountInfo() async {
    try {
      final resp = await DioUtils.get(path: "/login/status");
      return AccountModel.fromJson(resp);
    } catch (e) {
      LogUtil.e('获取账号信息失败: $e');
      throw Exception('Failed to fetch account info');
    }
  }
} 