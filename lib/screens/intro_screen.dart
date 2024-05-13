import 'package:check/components/colors.dart';
import 'package:check/components/shared_preferences.dart';
import 'package:check/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final TextStyle style = TextStyle(
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
  fontSize: 18,
  color: AppColors.whiteText,
);
final TextStyle titleStyle = TextStyle(
    color: AppColors.whiteText,
    fontFamily: "Poppins",
    fontWeight: FontWeight.bold,
    fontSize: 22);

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        styleTitle: titleStyle,
        styleDescription: style,
        title: "MANAGE ATTENDANCE",
        description:
            "Get started with Attendance Manager by effortlessly setting attendance sessions and securely sharing access with attendees using unique passwords.",
        pathImage: "assets/images/control.png",
        colorBegin: Colors.blue[800],
        colorEnd: Colors.blue[700],
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        backgroundImageFit: BoxFit.fill,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: "SECURE ACCESS",
        styleTitle: titleStyle,
        styleDescription: style,
        description:
            "Authenticate yourself to initiate attendance sessions, ensuring data integrity and accountability. ",
        pathImage: "assets/images/secure.png",
        colorBegin: Colors.blue[800],
        colorEnd: Colors.blue[700],
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        styleTitle: titleStyle,
        title: "EXPORT DATA",
        styleDescription: style,
        description:
            "Effortlessly export detailed attendee lists in Excel format after recording attendance",
        pathImage: "assets/images/save.png",
        colorBegin: Colors.blue[800],
        colorEnd: Colors.blue[700],
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      doneButtonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.whiteText),
          foregroundColor: WidgetStatePropertyAll(AppColors.blueText)),
      skipButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.whiteText),
        foregroundColor: WidgetStatePropertyAll(AppColors.blueText),
      ),
      nextButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.whiteText),
      ),
      indicatorConfig: IndicatorConfig(
        colorActiveIndicator: AppColors.whiteText,
      ),
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: () {
        SharedPreferences? prefs = SharedPrefs.instance;
        prefs.setBool("shownbefore", true);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
      },
    );
  }
}
