import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/widgets/create_attendance%20form.dart';
import 'package:flutter/material.dart';

class CreateAttendanceScreen extends StatelessWidget {
  const CreateAttendanceScreen({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          setAttendance,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteText),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(gradient: linearGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical! * 2,
                horizontal: SizeConfig.blockSizeHorizontal! * 2),
            child: Column(
              children: [
                CreateAttendanceForm(
                  username: username,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
