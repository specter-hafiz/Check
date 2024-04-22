import 'package:check/components/colors.dart';
import 'package:flutter/material.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({
    super.key,
    this.callback,
    required this.icon,
    required this.string,
  });
  final Function()? callback;
  final Icon icon;
  final String string;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: callback,
      child: Card(
        child: Container(
          width: orientation == Orientation.portrait
              ? size.height * 0.2
              : size.width * 0.2,
          height: orientation == Orientation.portrait
              ? size.height * 0.2
              : size.width * 0.2,
          decoration: BoxDecoration(
              color: AppColors.whiteText,
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(string),
            ],
          ),
        ),
      ),
    );
  }
}
