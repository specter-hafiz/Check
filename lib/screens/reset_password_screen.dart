import 'package:check/config/size_config.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            children: [
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
