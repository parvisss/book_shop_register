import 'package:book_shop/bloc/register_bloc/auth_bloc.dart';
import 'package:book_shop/bloc/register_bloc/auth_event.dart';
import 'package:book_shop/ui/screens/login/ui/screens/login_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  context.read<AuthBloc>().add(LogoutAuthEvent());
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => const LoginShop()));
                },
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
    );
  }
}
