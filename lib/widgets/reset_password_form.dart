import 'package:check/config/size_config.dart';
import 'package:check/screens/try_clip_path.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController nPasswordController = TextEditingController();
  final TextEditingController rPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordTextField(passwordcontroller: nPasswordController),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.0),
        PasswordTextField(passwordcontroller: rPasswordController),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1.0),
        AdminAttendeeButton(
          text: "Confirm",
          callback: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TryClipPath())),
        )
      ],
    ));
  }
}
