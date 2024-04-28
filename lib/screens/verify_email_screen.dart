import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.userEmail});
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email Screen"),
      ),
      body: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: "An verification email has been sent to "),
            TextSpan(text: userEmail),
            TextSpan(
                text:
                    "Please check your mail box to confirm and verify your email."),
          ]))
        ],
      ),
    );
  }
}
