import 'package:check/components/colors.dart';
import 'package:check/utilities/dialogs/generic_alert_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessMessage(
    BuildContext context, String message, String title) {
  return showGenericDialog(
      isDimissible: true,
      context: context,
      icon: Icon(
        Icons.check,
        color: AppColors.whiteText,
        size: 50,
      ),
      title: title,
      content: message,
      optionsBuilder: () => {
            "Ok": null,
          });
}
