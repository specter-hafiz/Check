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
      appBar: AppBar(
        title: const Text("Admin Signin Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight! * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
                    color: AppColors.whiteText,
                    borderRadius: BorderRadius.circular(24)),
                child:
                    Image(image: AssetImage("assets/images/signin_admin.jpg")),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
              ),
              Text(
                logintoacct,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.whiteText),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
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
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
