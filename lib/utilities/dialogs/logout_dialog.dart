import 'package:check/utilities/dialogs/generic_alert_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> logoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
      isDimissible: false,
      context: context,
      icon: Icon(Icons.logout),
      title: "Logout",
      content: "Are you sure you want to log out?",
      optionsBuilder: () => {
            "No": false,
            "Yes": true,
          }).then((value) => value ?? false);
}
