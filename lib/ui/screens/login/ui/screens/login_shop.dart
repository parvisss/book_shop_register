import 'package:book_shop/ui/screens/login/controller/login_controller.dart';
import 'package:book_shop/ui/screens/login/data/login_values.dart';
import 'package:book_shop/ui/screens/parolni_tiklash.dart';
import 'package:book_shop/ui/screens/register/ui/screens/tel_email_code.dart';
import 'package:book_shop/ui/screens/register/ui/widgets/check_code.dart';
import 'package:book_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginShop extends StatefulWidget {
  const LoginShop({super.key});

  @override
  State<LoginShop> createState() => _LoginShopState();
}

class _LoginShopState extends State<LoginShop> {
  final LoginController _authController = LoginController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset("assets/svgs/logo.svg"),
      ),
      body: SingleChildScrollView(
        child: LoginValues.isRegister
            ? const Center(
                child: CheckCode(isLogin: true),
              )
            : Column(
                children: [
                  ListTile(
                    title: Text(
                      "Log in",
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                    trailing: FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.colorGrey),
                        shape: WidgetStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const TelEmailCode()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: AppColors.colorBlack),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              _authController.toggleLoginMethod();
                            });
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: _authController.isPhoneLogin
                                ? AppColors.colorWhite
                                : AppColors.colorGrey,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Telefon Raqam",
                            style: TextStyle(color: AppColors.colorBlack),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              _authController.toggleLoginMethod();
                            });
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: !_authController.isPhoneLogin
                                ? AppColors.colorWhite
                                : AppColors.colorGrey,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Email",
                            style: TextStyle(color: AppColors.colorBlack),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: AppColors.colorGrey,
                  ),
                  const Gap(40),
                  ListTile(
                    title: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Log in'),
                    ),
                    subtitle: TextFormField(
                      controller: _authController.isPhoneLogin
                          ? _authController.phoneController
                          : _authController.emailController,
                      keyboardType: _authController.isPhoneLogin
                          ? TextInputType.phone
                          : TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixText: _authController.isPhoneLogin ? "+998" : '',
                        labelText: _authController.isPhoneLogin
                            ? "+998"
                            : "email@address.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: AppColors.colorRed,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const Gap(40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const ParolniTiklash()),
                        );
                      },
                      child: Text(
                        "Malumotlarni unutdingizmi?",
                        style: TextStyle(
                          color: AppColors.colorBlue,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.colorBlack),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            _authController.handleLogin(context);
            errorMessage = _authController.isPhoneLogin
                ? _authController.validatePhone()
                : _authController.validateEmail();
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: (MediaQuery.of(context).size.width) / 2 - 62),
          child: const Text("Kirish"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
