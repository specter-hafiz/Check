import 'package:check/components/colors.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.passwordcontroller,
  });

  final TextEditingController passwordcontroller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password field required";
        }

        return null;
      },
      controller: widget.passwordcontroller,
      style:
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),
      cursorColor: AppColors.blueText,
      obscureText: passwordVisible,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              color: AppColors.blueText,
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off)),
          prefixIconColor: AppColors.blueText,
          fillColor: AppColors.whiteText,
          filled: true,
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
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
