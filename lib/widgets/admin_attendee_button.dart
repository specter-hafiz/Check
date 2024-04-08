import 'package:check/components/colors.dart';
import 'package:flutter/material.dart';

class AdminAttendeeButton extends StatelessWidget {
  const AdminAttendeeButton({
    super.key,
    required this.text,
    this.callback,
  });
  final String text;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        child: Text(text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.blueText)),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 3, offset: Offset(0, 3))
        ], borderRadius: BorderRadius.circular(24), color: AppColors.whiteText),
      ),
    );
  }
}
