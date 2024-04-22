import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/admin_signin_screen.dart';
import 'package:check/screens/attendee_sigin_screen.dart';
import 'package:check/widgets/welcome_container.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal! * 2,
            right: SizeConfig.blockSizeHorizontal! * 2,
            top: SizeConfig.blockSizeVertical! * 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(welcome,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteText)),
            SizedBox(
              height: 8,
            ),
            Text(selectRole,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.normal, color: AppColors.whiteText)),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WelcomeContainer(
                  callback: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AdminSigninScreen()))),
                  icon: Icon(
                    Icons.person_pin,
                    size: 70,
                  ),
                  string: "Administrator",
                ),
                WelcomeContainer(
                  callback: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AttendeeSigninScreen()))),
                  icon: Icon(
                    Icons.school,
                    size: 70,
                  ),
                  string: "Attendee",
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
