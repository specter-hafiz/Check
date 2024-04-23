import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required Widget? titleWidget,
    required String content,
    required DialogOptionBuilder optionsBuilder}) {
  final options = optionsBuilder();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: titleWidget,
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return ElevatedButton(
                onPressed: () {
                  if (value != null) {
                    Navigator.of(context).pop(value);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(optionTitle));
          }).toList(),
        );
      });
}
