abstract class AccountEvent {}

class FetchAccountInfo extends AccountEvent {}

class LogoutEvent extends AccountEvent {}

class GetSmsCodeEvent extends AccountEvent {
  final String phone;

  GetSmsCodeEvent({required this.phone});
}
