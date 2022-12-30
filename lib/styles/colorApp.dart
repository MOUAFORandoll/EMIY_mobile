import 'package:flutter/material.dart';

abstract class ColorsApp {
  static const Color blue = Color.fromRGBO(27, 20, 100, 1);
  static const Color skyBlue = Color.fromRGBO(41, 171, 226, 1);
  static const Color bg = Color.fromRGBO(243, 243, 243, 1);
  static const Color bleuLight = Color(0xFF4E9DE8);
  static const Color black = Colors.black;
  static const Color grey = Color(0xFFF1F6FA);
  static const Color greySecond = Color(0xFFD8E9F6);
  static const Color bgCont = Color(0xFF0FAE74);
  static const Color greenLight = Color(0xFF45EFB1);
  static const Color textBlue = Color(0xFF2C0D58);
  static const Color red = Color(0xffB40001);
}

abstract class GradientApp {
  static const LinearGradient blueG = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.blue, ColorsApp.bg],
  );
  static const LinearGradient blueR = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.blue, Colors.red],
  );
  static const LinearGradient blueY = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.blue, Colors.yellow]);
}
