import 'package:check/components/colors.dart';
import 'package:check/config/size_config.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.userEmail});
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify Email",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteText),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 3),
        child: Column(
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "An verification email has been sent to ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18)),
              TextSpan(
                  text: userEmail + "\n",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.blueText,
                        fontSize: 19,
                      )),
              TextSpan(
                  text:
                      "Please check your mail box to confirm and verify your email.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18)),
            ])),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        ),
      ),
    );
  }
}
