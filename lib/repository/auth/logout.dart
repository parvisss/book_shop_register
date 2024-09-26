import 'package:book_shop/repository/shared_preferense_controller.dart';
import 'package:dio/dio.dart';

class Logout {
  Dio dio = Dio();

  Future<void> logout() async {
    try {
      String? token = await SharedPreferenseController.getToken();
      Response response = await dio.delete(
        'http://3.68.216.185:8069/auth/user/profile/delete',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201) {
        SharedPreferenseController.deleteToken();
      }
      SharedPreferenseController.deleteToken();
    } catch (e) {
      rethrow;
    }
  }
}
