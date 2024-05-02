import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/screens/forgot_password_screen.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/checkbox.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextForm extends StatefulWidget {
  const TextForm({
    super.key,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Email*"),
          TextFieldWidget(
            username: false,
            controller: emailcontroller,
            hinttext: "Email",
            prefixIcon: Icons.mail,
            readOnly: false,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
          Text("Password*"),
          PasswordTextField(
            passwordcontroller: passwordcontroller,
            callback: (_) {
              _ActionMethod(context);
            },
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 2.5),
          Row(children: [
            CheckBox(),
            Text(rememberMe, style: Theme.of(context).textTheme.bodyLarge),
            Spacer(),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Forgot password",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.whiteText),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
                  },
              ),
            ])),
          ]),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.whiteText,
                  ),
                )
              : AdminAttendeeButton(
                  text: login,
                  callback: () {
                    _ActionMethod(context);
                  }),
        ]));
  }

  void _ActionMethod(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Provider.of<AuthProvider>(context, listen: false)
          .signUserIn(emailcontroller.text.trim(),
              passwordcontroller.text.trim(), context)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      }).catchError((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }
}
