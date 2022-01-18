import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:royalkitchen/config/colors.dart';
import 'package:royalkitchen/screens/onBoarding/pageViews.dart';
import 'package:royalkitchen/utils/helpers.js.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final _introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    newPageDestroyPrevious(context, 'register');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        key: _introKey,
        pages: onBoardingPages.map((PageViewModel page) => page).toList(),
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        color: KColors.kSecondaryColor,
        dotsDecorator: const DotsDecorator(color: KColors.kSecondaryColor, activeColor: KColors.kPrimaryColor),
      ),
    );
  }
}
