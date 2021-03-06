import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/screens/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:royalkitchen/screens/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
        splash: 'assets/images/logo.png',
        splashIconSize: 200,
        screenFunction: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool firstTime = (prefs.getBool('first_time') ?? true);

          return firstTime ? Register() : const Home();
        },
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        backgroundColor: KColors.kPrimaryColor);
  }
}
