import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:check/config/size_config.dart';
import 'package:check/providers/auth_provider.dart';
import 'package:check/screens/create_attendance_screen.dart';
import 'package:check/screens/view_attendance_screen.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:check/utilities/dialogs/logout_dialog.dart';
import 'package:check/utilities/enums/menu_action.dart';
import 'package:check/widgets/admin_home_container.dart';
import 'package:check/widgets/appbar_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    String username = user!.displayName ?? "Unknown";
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
                    bool? shouldLogout = await logoutDialog(context);
                    if (shouldLogout!) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool("login", false);
                      Provider.of<AuthenticationProvider>(context,
                              listen: false)
                          .signUserOut(context);
                      Navigator.of(context);
                    } else {}
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
                  username,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal! * 2,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.25,
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
                                  username: username,
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
