import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/db_provider.dart';
import 'package:check/widgets/checkin_button.dart';
import 'package:check/widgets/mycircular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
final LinearGradient containerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.blue[900]!,
      Colors.blue[800]!,
      Colors.blue[700]!,
      Colors.blue[600]!,
      Colors.blue[500]!,
    ]);

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
        SizedBox(
          height: SizeConfig.screenHeight! * .25,
          child: Image.asset("assets/images/sign.png"),
        ),
        Material(
          elevation: 4,
          type: MaterialType.card,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            alignment: Alignment.center,
            height: SizeConfig.screenHeight! * 0.25,
            decoration: BoxDecoration(
                gradient: containerGradient,
                borderRadius: BorderRadius.circular(12)),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Welcome \n",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
              ),
              TextSpan(
                text: capitalize(widget.user),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ])),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal! * 2,
        ),
        Material(
          borderRadius: BorderRadius.circular(24),
          elevation: 4,
          type: MaterialType.card,
          child: Container(
            height: SizeConfig.screenHeight! * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: containerGradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  attendanceBy,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                ),
                Text(
                  widget.creatorName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  titleMeeting,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal! * 4,
        ),
        isLoading
            ? MyCircularProgressIndicator(
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
