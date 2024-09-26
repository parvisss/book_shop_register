final class AuthEvent {}

final class SendSmsAuthEvent extends AuthEvent {
  final String? phoneNumber;
  final String? email;
  final bool isLogin;

  SendSmsAuthEvent({
    required this.isLogin,
    this.phoneNumber,
    this.email,
  });
}

final class ConfirmSmsAuthEvent extends AuthEvent {
  final bool isLogin;
  final String password;
  final String? phone;
  final String? email;

  ConfirmSmsAuthEvent({
    required this.isLogin,
    required this.password,
    this.phone,
    this.email,
  });
}

final class LogoutAuthEvent extends AuthEvent {}
