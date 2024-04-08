import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:flutter/material.dart';

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: 40,
            ),
            Text(checkin,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.blueText)),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.whiteText),
      ),
    );
  }
}
