import 'package:flutter/material.dart';

class ScaffolMessengerWidget extends StatelessWidget {
  const ScaffolMessengerWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SnackBar(content: (Text(text)));
  }
}
