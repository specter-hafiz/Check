import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:check/widgets/checkbox.dart';
import 'package:check/widgets/password_textfield.dart';
import 'package:check/widgets/textfield_widget.dart';
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
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFieldWidget(
              username: false,
              controller: emailcontroller,
              hinttext: "Email",
              prefixIcon: Icons.mail,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1.2),
            PasswordTextField(
              passwordcontroller: passwordcontroller,
            ),
            Row(children: [
              CheckBox(),
              Text(rememberMe),
            ]),
            isLoading
                ? CircularProgressIndicator()
                : AdminAttendeeButton(
                    text: signin,
                    callback: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        Provider.of<AuthProvider>(context, listen: false)
                            .signUserIn(emailcontroller.text,
                                passwordcontroller.text, context)
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
                    }),
          ]),
        ));
  }
}
