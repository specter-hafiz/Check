import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/theme_provider.dart';
import 'package:check/screens/admin_signin_screen.dart';
import 'package:check/screens/attendee_sigin_screen.dart';
import 'package:check/widgets/welcome_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Icon(
          Icons.check_box_outlined,
          size: 35,
        ),
        title: Text(
          check,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(Icons.light_mode))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 2,
        ),
        child: Column(
          children: [
            orientation == Orientation.portrait
                ? SizedBox(height: SizeConfig.blockSizeVertical! * 5)
                : SizedBox(height: SizeConfig.blockSizeHorizontal! * 5),
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
                    )),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal! * 3,
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
