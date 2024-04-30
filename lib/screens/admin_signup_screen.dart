import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/widgets/back_button.dart';
import 'package:check/widgets/signup_form.dart';
import 'package:check/widgets/social_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AdminSignupScreen extends StatelessWidget {
  const AdminSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Backbutton(),
        title: Text(
          signup,
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
            children: [
              SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
              Text(
                signuptocontinue,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              SocialButton(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              SignUpForm(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Already have an account?",
                    style: Theme.of(context).textTheme.bodyLarge),
                TextSpan(
                  text: " Sign In",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.blueText, fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pop();
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
