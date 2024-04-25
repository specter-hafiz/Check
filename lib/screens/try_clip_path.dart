import 'package:flutter/material.dart';

class TryClipPath extends StatefulWidget {
  const TryClipPath({super.key});

  @override
  State<TryClipPath> createState() => _TryClipPathState();
}

class _TryClipPathState extends State<TryClipPath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.green),
        body: ClipPath(
          clipper: MYClipper(),
          child: Container(
            height: 200,
            color: Colors.green,
          ),
        ));
  }
}

class MYClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path(); //point 1
    final height = size.height;
    final width = size.width;
    p.lineTo(0.0, height * 0.5); //point 2
    //p.quadraticBezierTo(width * 0.25, height * 0.5, width * 0.5, height * 0.75);
    //p.quadraticBezierTo(width * 0.75, height, width, height * 0.75);
    p.quadraticBezierTo(width * 0.5, height, width, height * 0.5);

    p.lineTo(width, 0.0);

    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
