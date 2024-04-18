import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/widgets/checkin_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendeeHomeScreen extends StatelessWidget {
  const AttendeeHomeScreen({
    super.key,
    required this.user,
    required this.idNumber,
    required this.creatorName,
    required this.docId,
  });
  final String user;
  final String idNumber;
  final String creatorName;
  final String docId;

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
                "@" + user,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 30,
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal! * 2,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: SizeConfig.screenHeight! * 0.25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
                    color: AppColors.whiteText,
                  ),
                  child: Image(
                    image: AssetImage("assets/images/home_attendee.jpg"),
                    fit: BoxFit.fill,
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
                      "@" + creatorName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 30, fontWeight: FontWeight.w800),
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
              CheckInButton(
                callback: () => Provider.of<DBProvider>(context, listen: false)
                    .signAttendance(user, idNumber, context, docId),
              )
            ],
          ),
        ),
      ),
    );
  }
}
