import 'package:book_shop/repository/shared_preferense_controller.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio();
String sendSmsemail = 'http://3.68.216.185:8069/auth/sms/login/email';
String sendSmsphone = 'http://3.68.216.185:8069/auth/sms/login/phone';
String checkSmsPhone = 'http://3.68.216.185:8069/auth/user/phone/login';
String checkSmsEmail = 'http://3.68.216.185:8069/auth/user/email/login';

class Login {
  static Future sendSms({
    String? email,
    String? phoneNumber,
  }) async {
    try {
      await dio.post(
        email != null ? sendSmsemail : sendSmsphone,
        data: email != null
            ? {
                "email": email,
              }
            : {
                "phone": phoneNumber,
              },
      );
    } catch (e) {
      rethrow;
    }
  }

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
      if (response.statusCode == 200) {
        await SharedPreferenseController.saveToken(response.data['access_token']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
