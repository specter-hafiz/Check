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
        side: BorderSide(color: AppColors.whiteText),
        checkColor: AppColors.blueText,
        value: ischeck,
        activeColor: AppColors.whiteText,
        onChanged: (bool? value) {
          setState(() {
            ischeck = value!;
          });
        });
  }
}
