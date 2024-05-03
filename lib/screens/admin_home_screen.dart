import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/screens/create_attendance_screen.dart';
import 'package:check/screens/view_attendance_screen.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/utilities/dialogs/logout_dialog.dart';
import 'package:check/utilities/enums/menu_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key, required this.currentUser});
  final String currentUser;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarContainer(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/icon.png",
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          PopupMenuButton<MenuAction>(
              iconColor: AppColors.whiteText,
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await logoutDialog(context);
                    if (shouldLogout) {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signUserOut(context);
                    }
                    break;
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Logout"),
                      value: MenuAction.logout,
                      onTap: () async {
                        await logoutDialog(
                          context,
                        );
                      },
                    )
                  ])
        ],
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(gradient: linearGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal! * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  welcome + ",",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 2,
                ),
                Text(
                  currentUser,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 2,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 25,
                  child: Image.asset("assets/images/admin.png"),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          splashColor: Colors.blue[200],
                          borderRadius: BorderRadius.circular(22),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CreateAttendanceScreen(
                                  username: currentUser,
                                ),
                              ),
                            );
                          },
                          child: AdminHomeContainer(
                              text: "Create \n Attendance",
                              orientation: orientation,
                              size: size),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          splashColor: Colors.blue[200],
                          borderRadius: BorderRadius.circular(22),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ViewAttendanceScreen()),
                            );
                          },
                          child: AdminHomeContainer(
                              text: "View \n Attendance",
                              orientation: orientation,
                              size: size),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.blue[600]!,
            Colors.blue[600]!,
            Colors.blue[600]!,
          ])),
    );
  }
}

class AdminHomeContainer extends StatelessWidget {
  const AdminHomeContainer({
    super.key,
    required this.orientation,
    required this.size,
    required this.text,
  });

  final Orientation orientation;
  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: orientation == Orientation.portrait
          ? size.width * 0.8
          : size.width * 0.2,
      height: orientation == Orientation.portrait
          ? size.height * 0.2
          : size.width * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!,
                Colors.blue[500]!,
                Colors.blue[600]!,
                Colors.blue[700]!,
                Colors.blue[800]!,
                Colors.blue[900]!,
              ])),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
