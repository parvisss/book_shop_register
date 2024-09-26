import 'package:bloc/bloc.dart';
import 'package:book_shop/bloc/register_bloc/auth_event.dart';
import 'package:book_shop/bloc/register_bloc/auth_state.dart';
import 'package:book_shop/repository/auth/login.dart';
import 'package:book_shop/repository/auth/logout.dart';
import 'package:book_shop/repository/auth/register.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState()) {
    on<SendSmsAuthEvent>(_onSend);
    on<ConfirmSmsAuthEvent>(_onConfirm);
    on<LogoutAuthEvent>(_onLogout);
  }

//send sms
//! this code sends message(confirm code) to email/phone when user try to login/register
//! i used check operators to avoid unnasesery code

  void _onSend(SendSmsAuthEvent event, Emitter<AuthState> emit) async {
    try {
      event.phoneNumber != null
          ? event.isLogin
              ? await Login.sendSms(phoneNumber: event.phoneNumber)
              : await Register.sendSms(phoneNumber: event.phoneNumber)
          : event.isLogin
              ? await Login.sendSms(email: event.email)
              : await Register.sendSms(email: event.email);
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }

//?------------------------------------------------------------------------------------------------

//confirm code
//!  this code checks confirm code sended  to email/phone when user try to login/register
//! i used check operators to avoid unnasesery code

  void _onConfirm(ConfirmSmsAuthEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      event.email != null
          ? event.isLogin
              ? await Login.checkCode(
                  email: event.email,
                  code: event.password,
                )
              : await Register.checkCode(
                  email: event.email,
                  code: event.password,
                )
          : event.isLogin
              ? await Login.checkCode(
                  phone: event.phone,
                  code: event.password,
                )
              : await Register.checkCode(
                  phone: event.phone,
                  code: event.password,
                );
      emit(SuccessAuthState());
    } catch (e) {
      emit(
        ErrorAuthState(message: e.toString()),
      );
    }
  }
//?------------------------------------------------------------------------------------------------

  Future<void> _onLogout(LogoutAuthEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await Logout().logout();
      emit(InitialAuthState());
    } catch (e) {
      emit(ErrorAuthState(message: e.toString()));
    }
  }
}
