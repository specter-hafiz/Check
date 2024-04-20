import 'package:check/utilities/dialogs/generic_alert_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String errorString) {
  return showGenericDialog(
      context: context,
      title: "An error occurred",
      content: errorString,
      optionsBuilder: () => {
            "Ok": null,
          });
}
