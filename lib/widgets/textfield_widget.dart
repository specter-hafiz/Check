import 'package:check/components/colors.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.prefixIcon,
    this.username,
    this.onfieldSubmitted,
    this.focusNode,
    this.initialValue,
    required this.readOnly,
  });

  final TextEditingController controller;
  final String hinttext;
  final IconData prefixIcon;
  final bool? username;
  final FocusNode? focusNode;
  final String? initialValue;
  final Function(String)? onfieldSubmitted;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: linearGradient, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        readOnly: readOnly,
        initialValue: initialValue,
        focusNode: focusNode,
        onFieldSubmitted: onfieldSubmitted,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Field required";
          }
          if (value.length < 2) {
            return "Enter more than one character";
          }
          if (!username!) {
            if (!value.contains(".com")) {
              return "Invalid email format";
            }
            if (!value.contains("@")) {
              return "Missing @ sign";
            }
          }
          return null;
        },
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium!,
        cursorColor: AppColors.blueText,
        decoration: InputDecoration(
            hintText: hinttext,
            prefixIconColor: AppColors.whiteText,
            prefixIcon: Icon(prefixIcon),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whiteText),
                borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black45))),
      ),
    );
  }
}
