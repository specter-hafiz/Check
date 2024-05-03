import 'package:check/components/colors.dart';
import 'package:check/utilities/dialogs/generic_alert_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> deleteDialog(BuildContext context, String title) {
  return showGenericDialog<bool>(
      isDimissible: false,
      context: context,
      icon: Icon(
        Icons.warning_outlined,
        color: AppColors.whiteText,
        size: 50,
      ),
      title: title,
      content:
          "This action can not be undone !\n Are sure you want to continue",
      optionsBuilder: () => {
            "No": false,
            "Yes": true,
          }).then((value) => value ?? false);
}
