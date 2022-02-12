import 'package:flutter/material.dart';
import 'package:royalkitchen/config/colors.dart';

class Themes {
  static final kThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.grey,
      fontFamily: "Averta",
      primaryColor: KColors.kPrimaryColor,
      textTheme: Themes.kTextTheme,
      inputDecorationTheme: Themes.kDecorationTheme,
      elevatedButtonTheme: Themes.kElevatedButtonTheme);

  static final kElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: KColors.kPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)));

  static const kTextTheme = TextTheme(
    headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    subtitle1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: KColors.kPrimaryColor),
    subtitle2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: KColors.kTextColorDark),
  );

  static final kDecorationTheme = InputDecorationTheme(
    iconColor: KColors.kSecondaryColor,
    labelStyle: const TextStyle(color: KColors.kGreyColor, fontSize: 16),
    filled: true,
    fillColor: Colors.grey.shade200.withOpacity(.5),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: KColors.kPrimaryColor, width: .5),
        borderRadius: BorderRadius.circular(5)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: .5),
        borderRadius: BorderRadius.circular(5)),
  );
}
