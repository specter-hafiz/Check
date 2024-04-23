import 'package:check/config/size_config.dart';
import 'package:check/widgets/attendee_signin_form.dart';
import 'package:flutter/material.dart';

class AttendeeSigninScreen extends StatelessWidget {
  const AttendeeSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: AttendeeSignInForm(),
        )));
  }
}
