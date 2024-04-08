import 'package:check/config/size_config.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AttendeeSignInForm extends StatefulWidget {
  const AttendeeSignInForm({
    super.key,
  });

  @override
  State<AttendeeSignInForm> createState() => _AttendeeSignInFormState();
}

class _AttendeeSignInFormState extends State<AttendeeSignInForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFieldWidget(
            controller: nameController,
            hinttext: "Name",
            prefixIcon: Icons.person),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 1,
        ),
        TextFieldWidget(
            controller: idController,
            hinttext: "Id number",
            prefixIcon: Icons.badge),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 1,
        ),
        PasswordTextField(passwordcontroller: passwordController),
      ],
    ));
  }
}
