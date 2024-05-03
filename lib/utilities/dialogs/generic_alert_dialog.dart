import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required Icon icon,
    required String content,
    required DialogOptionBuilder optionsBuilder,
    required bool isDimissible}) {
  final options = optionsBuilder();
  return showDialog(
      barrierDismissible: isDimissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[800],
          icon: icon,
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                  Colors.black,
                )),
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop(context);
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
