import 'package:check/components/colors.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name*"),
            TextFieldWidget(
              username: true,
              controller: usernameController,
              hinttext: "Username",
              prefixIcon: Icons.person,
              readOnly: false,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
            Text("Email*"),
            TextFieldWidget(
              username: false,
              controller: emailController,
              hinttext: "Email",
              prefixIcon: Icons.mail,
              readOnly: false,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
            Text("Password*"),
            PasswordTextField(passwordcontroller: passwordController),
            Text("Must be at least 8 characters"),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blueText,
                    ),
                  )
                : AdminAttendeeButton(
                    text: "Sign Up",
                    callback: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Provider.of<AuthProvider>(context, listen: false)
                            .signUpUser(
                                usernameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context)
                            .then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        }).catchError((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                        ;
                      }
                    },
                  ),
          ],
        ));
  }
}
