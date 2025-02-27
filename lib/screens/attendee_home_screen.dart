import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/utilities/enums/menu_action.dart';
import 'package:check/widgets/appbar_container.dart';
import 'package:check/widgets/attendee_home_content.dart';
import 'package:flutter/material.dart';

class AttendeeHomeScreen extends StatelessWidget {
  const AttendeeHomeScreen({
    super.key,
    required this.user,
    required this.idNumber,
    required this.creatorName,
    required this.docId,
    required this.userId,
    required this.password,
    required this.meetingTitle,
  });
  final String user;
  final String idNumber;
  final String creatorName;
  final String meetingTitle;
  final String docId;
  final String userId;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarContainer(),
        titleSpacing: 0,
        leading: Icon(
          Icons.check_box_outlined,
          color: AppColors.whiteText,
          size: 35,
        ),
        title: Text(
          check,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          PopupMenuButton<MenuAction>(
              iconColor: AppColors.whiteText,
              onSelected: (value) {
                switch (value) {
                  case MenuAction.logout:
                    Navigator.of(context).pop();
                    break;
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () async {},
                      child: Text("Logout"),
                      value: MenuAction.logout,
                    ),
                  ])
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: linearGradient),
        height: SizeConfig.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal! * 2),
            child: attendeeHomeContent(
                user: user,
                creatorName: creatorName,
                meetingTitle: meetingTitle,
                idNumber: idNumber,
                userId: userId,
                password: password),
          ),
        ),
      ),
    );
  }
}
