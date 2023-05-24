import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ColorsApp {
  static const Color blue = Color(0xFF021040);
  static const Color bg = Color.fromRGBO(243, 243, 243, 1);

  static const Color skyBlue = Color(0xFF459FD6);
  static const Color textBlue = Color(0xFF1137FF) ;
  static const Color marron = Color(0xFFE7C76D) ;
 
  static const Color bleuLight = Color(0xFF4E9DD9);
  static const Color black = Colors.black;
  static const Color grey = Color(0xffD9D9D9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greySecond = Color(0xFFD8E9F6);
  static const Color greySearch = Color(0XFFF2F4F6);
  static const Color greyFirst = Color(0XFF505050);

  static const Color bgCont = Color(0xFF0FAE74);
  static const Color greenLight = Color(0xFF45EFB1);
  static const Color red = Color(0xffB40001);
  static const Color orange = Color.fromARGB(255, 254, 123, 97);
  static Color textColor =
      Get.isDarkMode ? Color(0xffB40001) : Color(0xFFF1F6FA);
}

abstract class GradientApp {
  static const LinearGradient blueG = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    // stops: [
    //   1.1,
    //   0.4,
    //   5.6,
    //   10.8,
    // ],
    colors: [
      Color(0xFF97E4C8),
      Color(0xFF80C7D8),
      Color(0xFF6FC9D5),
      // Color(0xFF56BAC7),
      Color(0xFF4DD1F6)
    ],
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
