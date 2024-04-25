import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/checkbox.dart';
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
          children: [
            TextFieldWidget(
              username: true,
              controller: usernameController,
              hinttext: "Username",
              prefixIcon: Icons.person,
              readOnly: false,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1.2,
            ),
            TextFieldWidget(
              username: false,
              controller: emailController,
              hinttext: "Email",
              prefixIcon: Icons.mail,
              readOnly: false,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1.2,
            ),
            PasswordTextField(passwordcontroller: passwordController),
            Row(children: [
              CheckBox(),
              Text(rememberMe),
            ]),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : AdminAttendeeButton(
                    text: "Sign Up",
                    callback: () {
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
