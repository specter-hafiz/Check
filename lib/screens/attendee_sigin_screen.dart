import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/admin_home_screen.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/widgets/attendee_signin_form.dart';
import 'package:flutter/material.dart';

class AttendeeSigninScreen extends StatelessWidget {
  const AttendeeSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: AppBarContainer(),
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(gradient: linearGradient),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal! * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 25,
                  child: Image.asset("assets/images/login.png"),
                ),
                Text(
                  login,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                AttendeeSignInForm(),
              ],
            ),
          )),
        ));
  }
}
