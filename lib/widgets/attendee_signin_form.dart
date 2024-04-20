import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            TextFieldWidget(
                username: true,
                controller: nameController,
                hinttext: "Name",
                prefixIcon: Icons.person),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            TextFieldWidget(
                username: true,
                controller: idController,
                hinttext: "Id number",
                prefixIcon: Icons.badge),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            PasswordTextField(passwordcontroller: passwordController),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            AdminAttendeeButton(
              text: signin,
              callback: () {
                if (_formkey.currentState!.validate()) {
                  Provider.of<AuthProvider>(context, listen: false)
                      .verifyAttendance(
                    context,
                    passwordController.text,
                    nameController.text,
                    idController.text,
                  );
                }
              },
            )
          ],
        ));
  }
}
