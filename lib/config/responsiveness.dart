import 'package:flutter/material.dart';

class Responsiveness extends StatelessWidget {
  const Responsiveness({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.smallmobile,
  });
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? smallmobile;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
      MediaQuery.of(context).size.width >= 768;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1200) {
      return desktop!;
    } else if (size.width >= 768 && tablet != null) {
      return tablet!;
    } else if (size.width >= 376 && size.width <= 768 && mobile != null) {
      return mobile!;
    } else {
      return smallmobile!;
    }
  }
}
