import 'package:check/components/colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.prefixIcon,
    this.username,
  });

  final TextEditingController controller;
  final String hinttext;
  final IconData prefixIcon;
  final bool? username;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return username! ? "Username field required" : "Email field required";
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
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      cursorColor: AppColors.blueText,
      decoration: InputDecoration(
          prefixIconColor: AppColors.blueText,
          fillColor: AppColors.whiteText,
          filled: true,
          hintText: hinttext,
          prefixIcon: Icon(prefixIcon),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.whiteText),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.whiteText))),
    );
  }
}
