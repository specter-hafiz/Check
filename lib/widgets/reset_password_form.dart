import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
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
        Text(npassword),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
        PasswordTextField(passwordcontroller: nPasswordController),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
        Text(rpassword),
        SizedBox(height: SizeConfig.blockSizeVertical! * 1),
        PasswordTextField(passwordcontroller: rPasswordController),
      ],
    ));
  }
}
