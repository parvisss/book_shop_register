import 'package:book_shop/bloc/register_bloc/auth_bloc.dart';
import 'package:book_shop/repository/shared_preferense_controller.dart';
import 'package:book_shop/ui/screens/home_screen.dart';
import 'package:book_shop/ui/screens/login/ui/screens/login_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder<String?>(
            future: SharedPreferenseController.getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                return const HomeScreen();
              } else {
                return const LoginShop();
              }
            },
          ),
        ),
      ),
    );
  }
}
