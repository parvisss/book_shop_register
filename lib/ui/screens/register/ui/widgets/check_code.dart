import 'package:book_shop/bloc/register_bloc/auth_bloc.dart';
import 'package:book_shop/bloc/register_bloc/auth_event.dart';
import 'package:book_shop/bloc/register_bloc/auth_state.dart';
import 'package:book_shop/ui/screens/home_screen.dart';
import 'package:book_shop/ui/screens/login/data/login_values.dart';
import 'package:book_shop/ui/screens/register/controller/controller_sms_check.dart';
import 'package:book_shop/ui/screens/register/data/register_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class CheckCode extends StatefulWidget {
  const CheckCode({super.key, required this.isLogin});
  final bool isLogin;

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCode> {
  final ControllerSmsCheek controllerRegister = ControllerSmsCheek();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SuccessAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PIN confirmed successfully')),
          );
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => const HomeScreen()));
        } else if (state is ErrorAuthState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Pinput(
              length: 6,
              defaultPinTheme: controllerRegister.defaultPinTheme,
              focusedPinTheme: controllerRegister.focusedPinTheme,
              submittedPinTheme: controllerRegister.submittedPinTheme,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {
                context.read<AuthBloc>().add(
                      widget.isLogin
                          ? ConfirmSmsAuthEvent(
                              isLogin: true,
                              password: pin,
                              phone: LoginValues.isNum
                                  ? LoginValues.phoneNumber
                                  : null,
                              email:
                                  !LoginValues.isNum ? LoginValues.email : null,
                            )
                          : ConfirmSmsAuthEvent(
                              isLogin: false,
                              password: pin,
                              phone: RegisterValues.isNum
                                  ? RegisterValues.phoneNumber
                                  : null,
                              email: !RegisterValues.isNum
                                  ? RegisterValues.email
                                  : null,
                            ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
