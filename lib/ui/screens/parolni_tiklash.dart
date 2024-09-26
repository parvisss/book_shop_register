import 'package:book_shop/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ParolniTiklash extends StatelessWidget {
  const ParolniTiklash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset("assets/svgs/logo.svg"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Log in",
                style: TextStyle(
                    color: AppColors.colorBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 28),
              ),
            ),
            const Gap(20),
            Container(
              height: 2,
              width: double.infinity,
              color: AppColors.colorGrey,
            ),
            const Gap(40),
            ListTile(
              title: const Text('Log in'),
              subtitle: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            ListTile(
              title: const Text('Parol'),
              subtitle: TextField(
                obscureText: true,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            ListTile(
              title: const Text('Parolni tasdiqlash'),
              subtitle: TextField(
                obscureText: true,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            const Gap(40),
          ],
        ),
      ),
      floatingActionButton: FilledButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.colorBlack),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            )),
        onPressed: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 130),
          child: Text("Saqlash"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
