import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ColorsApp {
  static const Color primaryBlue = Color(0xFF0C356A);
  static const Color secondBlue = Color(0xFF279EFF);
  static const Color mint = Color(0xFF40F8FF);
  static const Color greenLight = Color(0xFFD5FFD0);

  static const Color bg0 =    Color.fromRGBO(243, 243, 243, 1);
  static const Color bg =    Color.fromARGB(255, 255, 255, 255); //Color.fromRGBO(243, 243, 243, 1);
  static const Color bgColor = Color.fromARGB(255, 255, 255, 255);
  static const Color grey5 = Color(0xFFCBD6D6);

  static const Color skyBlue = Color(0xFF459FD6);
  static const Color marron = Color.fromARGB(255, 26, 24, 25);
  static const Color primaryText = primaryBlue; // Color(0xFFE7C76D);

  static const Color black =
      primaryBlue; // Color(0xFF343333); // ColorsApp.black;
  static const Color blackSecond =
      primaryBlue; // Color(0xFF343333); // ColorsApp.black;
  static const Color grey = Color(0xffD9D9D9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greySecond = Color(0xFFD8E9F6);
  static const Color greySearch = Color(0XFFF2F4F6);
  static const Color greyTh = Color.fromARGB(255, 214, 218, 223);
  static const Color greyTi = Color(0XFFC4C4C4);
  static const Color greyFirst = Color(0XFF505050);
  // static const Color greyX = Color.fromARGB(255, 131, 130, 130);
  static const Color grey1 = Color(0xFF8D9091);

  static const Color bgCont = mint; //Color(0xFF0FAE74);
  // static const Color greenLight = Color(0xFF45EFB1);
  static const Color red = Color.fromARGB(255, 254, 112, 112);
  static const Color orange = Color(0xffF29F05);
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
