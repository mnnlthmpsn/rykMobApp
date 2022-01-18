import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

Widget _buildFullscreenImage(String img) {
  return Image.asset(
    img,
    fit: BoxFit.contain,
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
  );
}

const pageDecoration = PageDecoration(
  titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
  bodyTextStyle: TextStyle(fontSize: 19.0),
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.zero,
);

final List<PageViewModel> onBoardingPages = [
  PageViewModel(
    title: "Fractional shares",
    body:
        "Instead of having to buy an entire share, invest any amount you want.",
    image: _buildFullscreenImage('assets/images/testimg.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "Enjoy shares",
    body:
        "Instead of having to buy an entire share, invest any amount you want.",
    image: _buildFullscreenImage('assets/images/testimg.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "Smile shares",
    body:
        "Instead of having to buy an entire share, invest any amount you want.",
    image: _buildFullscreenImage('assets/images/testimg.png'),
    decoration: pageDecoration,
  ),
];
