import '../models/account_model.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountModel account;
  AccountLoaded(this.account);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
} 