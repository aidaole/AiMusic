import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/dio_utils.dart';
import '../repositories/account_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;

  AccountBloc({required this.repository}) : super(AccountInitial()) {
    on<FetchAccountInfo>(_onFetchAccountInfo);
    on<LogoutEvent>(_onLogout);
    on<GetSmsCodeEvent>(_onGetSmsCode);
  }

  Future<void> _onFetchAccountInfo(
    FetchAccountInfo event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final account = await repository.getAccountInfo();
      final accountDetail =
          await repository.getAccountDetail(account.userId.toString());
      account.fans = accountDetail.profile?.followeds ?? 0;
      account.follows = accountDetail.profile?.follows ?? 0;
      emit(AccountSuccess(account));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  FutureOr<void> _onLogout(
      LogoutEvent event, Emitter<AccountState> emit) async {
    final succ = await repository.logout();
    if (succ) {
      emit(LogoutSuccess());
    } else {
      emit(LogoutFailed());
    }
  }

  FutureOr<void> _onGetSmsCode(
      GetSmsCodeEvent event, Emitter<AccountState> emit) async {
    // 获取短信验证码
    final phone = event.phone;
    final response = await DioUtils.get(path: '/captcha/sent?phone=$phone');

    // 如果请求成功且状态码为200,发送成功状态
    if (response != null && response['code'] == 200) {
      emit(GetSmsCodeSuccess(phone: phone)); // 发送成功状态,携带手机号
    } else {
      emit(GetSmsCodeFailed()); // 发送失败状态
    }
  }
}
