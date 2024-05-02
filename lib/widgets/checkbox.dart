import 'package:check/components/colors.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({
    super.key,
  });

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool ischeck = false;

  Widget build(BuildContext context) {
    return Checkbox(
        checkColor: AppColors.whiteText,
        value: ischeck,
        fillColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.white;
          } else if (states.contains(WidgetState.selected)) {
            return Colors.blue[900]!;
          }
          return Colors.blue[100]!;
        }),
        side: BorderSide(
          color: Colors.black,
        ),
        activeColor: Colors.white,
        onChanged: (bool? value) {
          setState(() {
            ischeck = value!;
          });
        });
  }
}
