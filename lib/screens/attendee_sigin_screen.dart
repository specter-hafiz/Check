import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/widgets/attendee_signin_form.dart';
import 'package:flutter/material.dart';

class AttendeeSigninScreen extends StatelessWidget {
  const AttendeeSigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendee Signin Screen"),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              height: SizeConfig.screenHeight! * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
                  color: AppColors.whiteText,
                  borderRadius: BorderRadius.circular(24)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image(
                    image: AssetImage("assets/images/signin_attendee.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            Text(
              signinToAttendance,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.whiteText),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            AttendeeSignInForm(),
          ]),
        )));
  }
}
