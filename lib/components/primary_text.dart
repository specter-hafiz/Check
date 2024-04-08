import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText(
      {super.key,
      required this.text,
      this.size = 20,
      required this.color,
      this.fontWeight = FontWeight.w400,
      this.height = 1.3});
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
