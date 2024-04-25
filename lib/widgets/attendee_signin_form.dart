import 'package:check/components/colors.dart';
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
  bool isLoading = false;
  FocusNode idFNode = FocusNode();
  FocusNode passwordFNode = FocusNode();
  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    passwordController.dispose();
    idFNode.dispose();
    passwordFNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Form(
        key: _formkey,
        child: Column(
          children: [
            if (orientation == Orientation.portrait)
              SizedBox(height: SizeConfig.blockSizeHorizontal! * 25),
            Text(
              attendee,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              signinToContinue,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20, color: AppColors.whiteText),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            TextFieldWidget(
              onfieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(idFNode);
              },
              username: true,
              controller: nameController,
              hinttext: "Name",
              prefixIcon: Icons.person,
              readOnly: false,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            TextFieldWidget(
              focusNode: idFNode,
              username: true,
              controller: idController,
              hinttext: "Id number",
              prefixIcon: Icons.badge,
              readOnly: false,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            PasswordTextField(passwordcontroller: passwordController),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            isLoading
                ? CircularProgressIndicator(
                    color: AppColors.whiteText,
                  )
                : AdminAttendeeButton(
                    text: signin,
                    callback: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Provider.of<AuthProvider>(context, listen: false)
                            .verifyAttendance(
                          context,
                          passwordController.text,
                          nameController.text,
                          idController.text,
                          nameController,
                          idController,
                          passwordController,
                        )
                            .then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      }
                    },
                  )
          ],
        ));
  }
}
