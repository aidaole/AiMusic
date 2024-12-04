import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/account_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;

  AccountBloc({required this.repository}) : super(AccountInitial()) {
    on<FetchAccountInfo>(_onFetchAccountInfo);
  }

  Future<void> _onFetchAccountInfo(
    FetchAccountInfo event,
    Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    try {
      final account = await repository.getAccountInfo();
      emit(AccountLoaded(account));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
} 