import 'dart:async';

import 'package:ai_music/modules/explore/repos/play_list_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/dio_utils.dart';
import '../repositories/account_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository accountRepo;
  final PlayListRepo playListRepo;

  AccountBloc({required this.accountRepo, required this.playListRepo})
      : super(AccountInitial()) {
    on<FetchAccountInfo>(_onFetchAccountInfo);
    on<LogoutEvent>(_onLogout);
    on<GetSmsCodeEvent>(_onGetSmsCode);
    on<GetAccountPlaylistsEvent>(_onGetAccountPlaylists);
    on<GetAccountHistoryPlayListEvent>(_onGetAccountHistoryPlayList);
  }

  Future<void> _onFetchAccountInfo(
    FetchAccountInfo event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final account = await accountRepo.getAccountInfo();
      final accountDetail =
          await accountRepo.getAccountDetail(account.userId.toString());
      account.fans = accountDetail.profile?.followeds ?? 0;
      account.follows = accountDetail.profile?.follows ?? 0;
      emit(AccountSuccess(account));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  FutureOr<void> _onLogout(
      LogoutEvent event, Emitter<AccountState> emit) async {
    final succ = await accountRepo.logout();
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

  FutureOr<void> _onGetAccountPlaylists(
      GetAccountPlaylistsEvent event, Emitter<AccountState> emit) async {
    final uid = event.uid;
    emit(GetAccountPlaylistsLoading());
    final playlists = await playListRepo.getAccountPlaylists(uid);
    emit(GetAccountPlaylistsSuccess(playlists));
  }

  FutureOr<void> _onGetAccountHistoryPlayList(
      GetAccountHistoryPlayListEvent event, Emitter<AccountState> emit) async {
    final uid = event.uid;
    emit(GetAccountHistoryPlayListLoading());
    final historyPlayList = await playListRepo.getAccountHistoryPlayList(uid);
    emit(GetAccountHistoryPlayListSuccess(historyPlayList));
  }
}
