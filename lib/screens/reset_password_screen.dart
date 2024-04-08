import 'package:check/config/size_config.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';

import '../components/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password Screen"),
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
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 7)],
                    color: AppColors.whiteText,
                    borderRadius: BorderRadius.circular(24)),
                child: Image(
                    image: AssetImage("assets/images/reset_password.jpg")),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 2),
              ResetPasswordForm(),
              SizedBox(height: SizeConfig.blockSizeVertical! * 4),
              AdminAttendeeButton(text: "Confirm")
            ],
          ),
        ),
      ),
    );
  }
}
