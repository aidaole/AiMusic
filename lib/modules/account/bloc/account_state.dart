import '../models/account_model.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final AccountModel account;
  AccountSuccess(this.account);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}

class LogoutSuccess extends AccountState {}

class LogoutFailed extends AccountState {}

class GetSmsCodeSuccess extends AccountState {
  final String phone;

  GetSmsCodeSuccess({required this.phone});
}

class GetSmsCodeFailed extends AccountState {}
