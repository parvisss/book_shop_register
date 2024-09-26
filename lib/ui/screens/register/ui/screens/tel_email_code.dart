import 'package:book_shop/ui/screens/register/controller/register_controller.dart';
import 'package:book_shop/ui/screens/register/data/register_values.dart';
import 'package:book_shop/ui/screens/register/ui/widgets/check_code.dart';
import 'package:book_shop/utils/constants/app_colors.dart';
import 'package:book_shop/utils/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class TelEmailCode extends StatefulWidget {
  const TelEmailCode({super.key});

  @override
  State<TelEmailCode> createState() => _TelEmailCodeState();
}

class _TelEmailCodeState extends State<TelEmailCode> {
  final RegisterController _registerController = RegisterController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset("assets/svgs/logo.svg"),
      ),
      body: RegisterValues.isRegister
          ? const Center(
              child: CheckCode(isLogin: false),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                _registerController.toggleLoginMethod();
                              });
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor:
                                  _registerController.isPhoneRegister
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
                                _registerController.toggleLoginMethod();
                              });
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor:
                                  _registerController.isPhoneRegister
                                      ? AppColors.colorGrey
                                      : AppColors.colorWhite,
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
                    Text(
                        _registerController.isPhoneRegister
                            ? 'Telefon raqamingizni kiriting*'
                            : 'e-mail manzil kiriting*',
                        style: AppTexts.mainTextH2),
                    const Gap(20),
                    RegisterValues.isRegister
                        ? const Center(
                            child: CheckCode(
                            isLogin: false,
                          ))
                        : TextFormField(
                            controller: _registerController.isPhoneRegister
                                ? _registerController.phoneController
                                : _registerController.emailController,
                            keyboardType: _registerController.isPhoneRegister
                                ? TextInputType.phone
                                : TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixText: _registerController.isPhoneRegister
                                  ? '+998'
                                  : '',
                              labelText: _registerController.isPhoneRegister
                                  ? '+998'
                                  : "email@address.com",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
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
                    const Gap(20),
                  ],
                ),
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.colorGrey),
              shape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
            ),
            onPressed: () {
              RegisterValues.email = '';
              RegisterValues.phoneNumber = '';
              RegisterValues.isNum = true;
              RegisterValues.isRegister = false;
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: (MediaQuery.of(context).size.width / 16) - 11),
              child: Text(
                "Bekor qilish",
                style: TextStyle(color: AppColors.colorBlack),
              ),
            ),
          ),
          RegisterValues.isRegister
              ? const SizedBox()
              : FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColors.colorBlack),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _registerController.handleLogin(context);
                        errorMessage = _registerController.isPhoneRegister
                            ? _registerController.validatePhone()
                            : _registerController.validateEmail();
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal:
                            (MediaQuery.of(context).size.width / 16) - 11),
                    child: const Text("Keyingisi"),
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
