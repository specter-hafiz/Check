import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/create_attendance_screen.dart';
import 'package:check/screens/view_attendance_screen.dart';
import 'package:check/widgets/admin_attendee_button.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Icon(
          Icons.check_box_outlined,
          color: AppColors.whiteText,
          size: 35,
        ),
        title: Text(
          "Check",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          PopupMenuButton(
              iconColor: AppColors.whiteText,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Logout"),
                      value: "Log",
                    )
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                welcome + ",",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.whiteText,
                      fontSize: 20,
                    ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal! * 2,
              ),
              Text(
                username,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal! * 2,
              ),
              Container(
                height: SizeConfig.screenHeight! * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
                    color: AppColors.whiteText,
                    borderRadius: BorderRadius.circular(24)),
                child: Image(image: AssetImage("assets/images/home_admin.jpg")),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal! * 4,
              ),
              AdminAttendeeButton(
                text: createAttendance,
                callback: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateAttendanceScreen(),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal! * 4,
              ),
              AdminAttendeeButton(
                text: viewAttendance,
                callback: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewAttendanceScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
