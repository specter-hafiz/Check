import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/widgets/signup_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AdminSignupScreen extends StatelessWidget {
  const AdminSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            children: [
              if (orientation == Orientation.portrait)
                SizedBox(height: SizeConfig.blockSizeHorizontal! * 25),
              Text(
                admin,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                signuptocontinue,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20, color: AppColors.whiteText),
              ),
              SignUpForm(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Already have an account?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.whiteText)),
                TextSpan(
                  text: " Sign In",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
