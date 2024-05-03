import 'package:flutter/material.dart';

class AdminHomeContainer extends StatelessWidget {
  const AdminHomeContainer({
    super.key,
    required this.orientation,
    required this.size,
    required this.text,
  });

  final Orientation orientation;
  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: orientation == Orientation.portrait
          ? size.width * 0.8
          : size.width * 0.2,
      height: orientation == Orientation.portrait
          ? size.height * 0.2
          : size.width * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!,
                Colors.blue[500]!,
                Colors.blue[600]!,
                Colors.blue[700]!,
                Colors.blue[800]!,
                Colors.blue[900]!,
              ])),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
