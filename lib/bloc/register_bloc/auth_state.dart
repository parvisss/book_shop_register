final class AuthState {}

final class InitialAuthState extends AuthState {}

final class SuccessAuthState extends AuthState {
  SuccessAuthState();
}

final class LoadingAuthState extends AuthState {}

final class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState({required this.message});
}
