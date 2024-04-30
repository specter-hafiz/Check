import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/widgets/attendee_signin_form.dart';
import 'package:check/widgets/back_button.dart';
import 'package:flutter/material.dart';

class AttendeeSigninScreen extends StatelessWidget {
  const AttendeeSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: Backbutton(),
          title: Text(
            login,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: AttendeeSignInForm(),
        )));
  }
}
