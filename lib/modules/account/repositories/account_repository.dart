import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/log_util.dart';
import '../../../network/dio_utils.dart';
import '../models/account_detail/account_detail.dart';
import '../models/account_model.dart';

class AccountRepository {
  static const String _cacheKey = 'account_cache';

  Future<AccountModel> getAccountInfo() async {
    try {
      // 先尝试从缓存中获取数据
      final cachedAccount = await _getCachedAccount();
      if (cachedAccount != null) {
        return cachedAccount;
      }

      // 如果缓存中没有数据，则从网络获取
      final resp = await DioUtils.get(path: "/login/status");
      final account = AccountModel.fromJson(resp);

      // 将获取到的数据缓存起来
      await _cacheAccount(resp);

      return account;
    } catch (e) {
      LogUtil.e('获取账号信息失败: $e');
      throw Exception('Failed to fetch account info');
    }
  }

  Future<bool> logout() async {
    final resp = await DioUtils.get(path: "/logout");
    if (resp['code'] == 200) {
      LogUtil.d('退出登录成功');
      await _clearCachedAccount();
      return true;
    } else {
      LogUtil.e('退出登录失败: ${resp['message']}');
      return false;
    }
  }

  Future<AccountModel?> _getCachedAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      return AccountModel.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> _cacheAccount(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(json);
    await prefs.setString(_cacheKey, jsonString);
  }

  Future<void> _clearCachedAccount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }

  Future<AccountDetail> getAccountDetail(String uid) async {
    final resp = await DioUtils.get(path: "/user/detail?uid=$uid");
    return AccountDetail.fromJson(resp);
  }
}
