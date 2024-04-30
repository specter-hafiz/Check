import 'package:check/components/colors.dart';
import 'package:check/components/strings.dart';
import 'package:flutter/material.dart';

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    super.key,
    this.callback,
  });
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: callback,
      child: Card(
        elevation: 3,
        child: Container(
          alignment: Alignment.center,
          height: 70,
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
                      fontWeight: FontWeight.bold, color: AppColors.whiteText)),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.blueText.withOpacity(0.8)),
        ),
      ),
    );
  }
}
