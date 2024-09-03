import 'package:check/components/shared_preferences.dart';
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String username = 'Admin'; // Default value if username is not found

  @override
  void initState() {
    super.initState();
    print(username);
    _loadUsername();
    print(username);
  }

  // Retrieve the username from SharedPreferences
  Future<void> _loadUsername() async {
    try {
      final prefs = SharedPrefs.instance;
      setState(() {
        username = prefs.getString('username') ??
            'Admin'; // Default to 'Admin' if no username is found
      });
    } catch (e) {
      print("Error loading username: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final orientation = MediaQuery.of(context).orientation;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Check",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
        ),
        titleSpacing: 0,
        flexibleSpace: const AppBarContainer(),
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
              if (value == MenuAction.logout) {
                bool? shouldLogout = await logoutDialog(context);

                if (shouldLogout!) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("login", false);
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .signUserOut(context);
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("Logout"),
                value: MenuAction.logout,
              )
            ],
          )
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
                  "$welcome,",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                Text(
                  username, // Display the username retrieved from SharedPreferences
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.25,
                  child: Image.asset("assets/images/admin.png"),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal! * 5),
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
                            size: size,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                                builder: (context) =>
                                    const ViewAttendanceScreen(),
                              ),
                            );
                          },
                          child: AdminHomeContainer(
                            text: "View \n Attendance",
                            orientation: orientation,
                            size: size,
                          ),
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
