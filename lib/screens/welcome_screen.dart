import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/admin_signin_screen.dart';
import 'package:check/screens/attendee_sigin_screen.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal! * 2,
              right: SizeConfig.blockSizeHorizontal! * 2,
              top: SizeConfig.blockSizeVertical! * 10),
          child: Column(
            children: [
              Container(
                height: (DeviceOrientation == DeviceOrientation.landscapeLeft ||
                        DeviceOrientation == DeviceOrientation.landscapeRight)
                    ? MediaQuery.of(context).size.height * 0.2
                    : MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 7)],
                    color: AppColors.whiteText,
                    borderRadius: BorderRadius.circular(24)),
                child: Image(image: AssetImage("assets/images/welcome.jpg")),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Text(welcome,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteText)),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              Text(selectRole,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.whiteText)),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              AdminAttendeeButton(
                text: admin,
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AdminSigninScreen())));
                },
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              AdminAttendeeButton(
                text: attendee,
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AttendeeSigninScreen())));
                },
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
