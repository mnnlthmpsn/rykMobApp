import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/screens/home/home.dart';
import 'package:royalkitchen/screens/onBoarding/onBoarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen.withScreenFunction(
        splash: const Icon(Icons.home, color: Colors.white, size: 80),
        screenFunction: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool firstTime = (prefs.getBool('first_time') ?? true);
          print(firstTime);
          return firstTime ? OnBoarding() : const Home();
        },
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        backgroundColor: KColors.kPrimaryColor);
  }
}
