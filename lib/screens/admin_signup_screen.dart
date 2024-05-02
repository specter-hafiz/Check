import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/widgets/signup_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AdminSignupScreen extends StatelessWidget {
  const AdminSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(gradient: linearGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical! * 4,
                horizontal: SizeConfig.blockSizeHorizontal! * 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.25,
                  child: Image.asset("assets/images/signup.png"),
                ),
                Text(
                  signup,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 1.0),
                SignUpForm(),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(
                    text: " Sign In",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.whiteText,
                        fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
