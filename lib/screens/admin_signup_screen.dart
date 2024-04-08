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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Signup Screen"),
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
                    Image(image: AssetImage("assets/images/signup_admin.jpg")),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
              ),
              Text(
                createNAcct,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.whiteText),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 1,
              ),
              SignUpForm(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2),
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
