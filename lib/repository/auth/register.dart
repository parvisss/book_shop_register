import 'package:book_shop/repository/shared_preferense_controller.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio();

String sendSmsemail = 'http://3.68.216.185:8069/auth/sms/register/email';
String sendSmsphone = 'http://3.68.216.185:8069/auth/sms/register/phone';
String checkSmsPhone = 'http://3.68.216.185:8069/auth/user/phone/register';
String checkSmsEmail = 'http://3.68.216.185:8069/auth/user/email/register';

//! gets sms by phoen and email
class Register {
  static Future sendSms({
    String? phoneNumber,
    String? email,
  }) async {
    try {
      await dio.post(
        email != null ? sendSmsemail : sendSmsphone,
        data: email != null
            ? {
                'email': email,
              }
            : {
                'phone': phoneNumber,
              },
      );
    } catch (e) {
      rethrow;
    }
  }

//! check the code come from sms
  static Future checkCode({
    String? phone,
    String? email,
    required String code,
  }) async {
    try {
      Response response = await dio.post(
        email != null ? checkSmsEmail : checkSmsPhone,
        data: email != null
            ? {
                "confirmation_code": code,
                "email": email,
              }
            : {
                "confirmation_code": code,
                "phone": phone,
              },
      );
      if (response.statusCode == 201) {
        SharedPreferenseController.saveToken(response.data['access_token']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
