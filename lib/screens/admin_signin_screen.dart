import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/admin_signup_screen.dart';
import 'package:check/widgets/back_button.dart';
import 'package:check/widgets/social_button.dart';
import 'package:check/widgets/textform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AdminSigninScreen extends StatelessWidget {
  const AdminSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Backbutton(),
        title: Text(
          login,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              Text("Login in with one of the following"),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              SocialButton(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              TextForm(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Don't have an account?  ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextSpan(
                  text: "Sign up",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.blueText, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminSignupScreen()));
                    },
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
