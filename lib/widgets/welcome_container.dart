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
    return Material(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      type: MaterialType.card,
      child: InkWell(
        onTap: callback,
        child: Container(
          width: orientation == Orientation.portrait
              ? size.width * 0.8
              : size.width * 0.2,
          height: orientation == Orientation.portrait
              ? size.height * 0.2
              : size.width * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Colors.blue[800]!,
                Colors.blue[700]!,
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(string, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
