import 'package:book_shop/ui/screens/register/data/register_values.dart';
import 'package:flutter/material.dart';
import 'package:book_shop/bloc/register_bloc/auth_bloc.dart';
import 'package:book_shop/bloc/register_bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isPhoneRegister = true;

  // Validate phone number
  String? validatePhone() {
    final phone = phoneController.text;
    if (phone.isEmpty || phone.length != 9) {
      return 'Iltimos, 9 ta raqamdan iborat yaroqli telefon raqamini kiriting.';
    }
    return null;
  }

  // Validate email
  String? validateEmail() {
    final email = emailController.text;
    if (email.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return "Iltimos, to'g'ri e-mail kiriting.";
    }
    return null;
  }

  // Switch between phone and email input
  void toggleLoginMethod() {
    isPhoneRegister = !isPhoneRegister;
  }

  // Handle the login process
  void handleLogin(BuildContext context) {
    String? error;
    if (isPhoneRegister) {
      error = validatePhone();
    } else {
      error = validateEmail();
    }
    if (error == null) {
      context.read<AuthBloc>().add(
            SendSmsAuthEvent(
              isLogin: false,
              phoneNumber: RegisterValues.isNum ? phoneController.text : null,
              email: RegisterValues.isNum ? null : emailController.text,
            ),
          );
      RegisterValues.isRegister = true;

      if (isPhoneRegister) {
        RegisterValues.phoneNumber = phoneController.text;
      } else {
        RegisterValues.email = emailController.text;
      }
    }
  }
}
