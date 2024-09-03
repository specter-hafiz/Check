import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/admin_signin_screen.dart';
import 'package:check/screens/attendee_sigin_screen.dart';
import 'package:check/widgets/welcome_container.dart';
import 'package:flutter/material.dart';

final LinearGradient linearGradient = LinearGradient(
    colors: [
      Colors.blue[600]!,
      Colors.blue[700]!,
      Colors.blue[800]!,
      Colors.blue[900]!,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.mirror);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: linearGradient),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 2,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                orientation == Orientation.portrait
                    ? SizedBox(height: SizeConfig.blockSizeVertical! * 5)
                    : SizedBox(height: SizeConfig.blockSizeHorizontal! * 5),
                Container(
                  width: double.infinity,
                  height: SizeConfig.blockSizeVertical! * 30,
                  child: Image.asset("assets/images/welcome.png"),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 3,
                ),
                Text(welcome,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        )),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 3,
                ),
                Text(selectRole,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: AppColors.whiteText)),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 3,
                ),
                WelcomeContainer(
                  callback: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AdminSigninScreen()))),
                  icon: Icon(
                    color: AppColors.whiteText,
                    Icons.person_pin,
                    size: 70,
                  ),
                  string: "Administrator",
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 3,
                ),
                WelcomeContainer(
                  callback: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AttendeeSigninScreen()))),
                  icon: Icon(
                    color: AppColors.whiteText,
                    Icons.school,
                    size: 70,
                  ),
                  string: "Attendee",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
