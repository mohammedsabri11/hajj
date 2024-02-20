import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ThemeText {
  static const TextStyle headline1 = TextStyle(
      fontFamily: 'Cairo',
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w700);

  static const TextStyle headline2 = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static const TextStyle headline3 = TextStyle(
      fontFamily: 'Cairo',
      color: Colors.green,
      fontSize: 28,
      height: 1.1,
      fontWeight: FontWeight.w600);
  static const TextStyle headline4 = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w600);
  static const TextStyle headline5 = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.w500);
  static const TextStyle buttonText = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600);
  static const TextStyle buttonText2 = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400);
  static const TextStyle LisTextTitle =
      TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.w400);
  static const TextStyle textBody =
      TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.w400 , color: Colors.black,);
  static const TextStyle textBody2 = TextStyle(
      fontFamily: 'cairo',
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400);
}
