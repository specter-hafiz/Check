import 'package:check/utilities/dialogs/generic_alert_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showMessageDialog(
    BuildContext context, String message, Icon icon) {
  return showGenericDialog(
      context: context,
      titleWidget: icon,
      content: message,
      optionsBuilder: () => {
            "Ok": null,
          });
}
