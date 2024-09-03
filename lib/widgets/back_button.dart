import 'package:flutter/material.dart';

class Backbutton extends StatelessWidget {
  const Backbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.5))),
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
