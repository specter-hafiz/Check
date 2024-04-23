import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/utilities/enums/menu_action.dart';
import 'package:check/widgets/checkin_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendeeHomeScreen extends StatelessWidget {
  const AttendeeHomeScreen({
    super.key,
    required this.user,
    required this.idNumber,
    required this.creatorName,
    required this.docId,
    required this.userId,
    required this.password,
  });
  final String user;
  final String idNumber;
  final String creatorName;
  final String docId;
  final String userId;
  final String password;

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
          check,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
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
                    )
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2),
          child: attendeeHomeContent(
              user: user,
              creatorName: creatorName,
              idNumber: idNumber,
              userId: userId,
              password: password),
        ),
      ),
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class attendeeHomeContent extends StatefulWidget {
  const attendeeHomeContent({
    super.key,
    required this.user,
    required this.creatorName,
    required this.idNumber,
    required this.userId,
    required this.password,
  });

  final String user;
  final String creatorName;
  final String idNumber;
  final String userId;
  final String password;

  @override
  State<attendeeHomeContent> createState() => _attendeeHomeContentState();
}

class _attendeeHomeContentState extends State<attendeeHomeContent> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            alignment: Alignment.center,
            height: SizeConfig.screenHeight! * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
              color: AppColors.whiteText,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  welcome,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text(
                  capitalize(widget.user),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal! * 2,
        ),
        Container(
          height: SizeConfig.screenHeight! * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                attendanceBy,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.blueText, fontSize: 25),
              ),
              Text(
                widget.creatorName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
              Text(
                titleMeeting,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.blueText, fontSize: 25),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal! * 4,
        ),
        isLoading
            ? CircularProgressIndicator(
                color: AppColors.whiteText,
              )
            : CheckInButton(callback: () {
                setState(() {
                  isLoading = true;
                });
                Provider.of<DBProvider>(context, listen: false)
                    .signAttendance(widget.user, widget.idNumber, context,
                        widget.userId, widget.password)
                    .then((_) {
                  setState(() {
                    isLoading = false;
                  });
                }).catchError((_) {
                  setState(() {
                    isLoading = false;
                  });
                });
              })
      ],
    );
  }
}
