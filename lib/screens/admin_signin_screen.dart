import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/admin_signup_screen.dart';
import 'package:check/screens/forgot_password_screen.dart';
import 'package:check/widgets/textform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AdminSigninScreen extends StatelessWidget {
  const AdminSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              admin,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              signinToContinue,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            ),
            TextForm(),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Forgot password?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black)),
              TextSpan(
                text: " Click here",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.whiteText, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
                  },
              )
            ])),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Don't have account yet?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.whiteText)),
              TextSpan(
                text: " Sign Up",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminSignupScreen()));
                  },
              )
            ]))
          ],
        ),
      ),
    );
  }
}
