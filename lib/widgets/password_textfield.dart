import 'package:check/components/colors.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.passwordcontroller,
    this.hintText,
    this.callback,
  });

  final TextEditingController passwordcontroller;
  final String? hintText;
  final Function(String)? callback;

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: linearGradient,
      ),
      child: TextFormField(
        onFieldSubmitted: widget.callback,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Field required";
          }
          if (value.length < 8) {
            return "Password must be 8 digits or more";
          }

          return null;
        },
        controller: widget.passwordcontroller,
        style: Theme.of(context).textTheme.bodyMedium!,
        cursorColor: AppColors.blueText,
        obscureText: passwordVisible,
        decoration: InputDecoration(
            suffixIconColor: AppColors.whiteText,
            prefixIconColor: AppColors.whiteText,
            labelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off)),
            hintText: widget.hintText ?? "Password",
            prefixIcon: Icon(Icons.lock),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
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
