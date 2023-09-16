import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';

class TexteStyle {
  final errorStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: kSmText,
    color: ColorsApp.red,
  );

  final primaryTextStyle = TextStyle(
    fontFamily: 'Lato',
    color: ColorsApp.primaryText,
    fontSize: kSmText,
  );
  final bprimaryTextStyle = TextStyle(
      fontFamily: 'Lato',
      color: ColorsApp.primaryText,
      fontSize: kSmText,
      fontWeight: FontWeight.w600);
  final secondaryTextStyle = TextStyle(
    fontFamily: 'Lato',
    color: ColorsApp.primaryText,
    fontSize: kSmText,
  );
  final bsecondaryTextStyle = TextStyle(
      fontFamily: 'Lato',
      color: ColorsApp.primaryText,
      fontSize: kSmText,
      fontWeight: FontWeight.w600);
  final largeTextStyle = TextStyle(
    fontFamily: 'Lato',
    color: ColorsApp.primaryText,
    fontSize: kLgText,
  );
  final blargeTextStyle = TextStyle(
      fontFamily: 'Lato',
      color: ColorsApp.primaryText,
      fontSize: kLgText,
      fontWeight: FontWeight.w600);
}

class ThemeStyle {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: ColorsApp.primaryText,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    dividerColor: ColorsApp.greyTh,
    textTheme: TextTheme(
      bodyText2: TextStyle(fontFamily: 'Lato', color: ColorsApp.primaryText),
    ),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    // Couleur du texte principal
    backgroundColor: ColorsApp.bgColor,

    primaryTextTheme: TextTheme(headline6: TexteStyle().primaryTextStyle),

    // Couleur du bouton pour autoriser la localisation
    // Couleur du bouton pour refuser la localisation
    disabledColor: ColorsApp.greySearch,
    dividerColor: Colors.white54,

    textTheme: TextTheme(
      bodyLarge: TexteStyle().largeTextStyle,
      displayLarge: TexteStyle().largeTextStyle,
      displayMedium: TexteStyle().secondaryTextStyle,
      displaySmall: TexteStyle().primaryTextStyle,
      headlineMedium: TexteStyle().secondaryTextStyle,
      headlineSmall: TexteStyle().primaryTextStyle,
      bodyMedium: TexteStyle().largeTextStyle,
      bodySmall: TexteStyle().primaryTextStyle,
      labelLarge: TexteStyle().largeTextStyle,
      labelSmall: TexteStyle().primaryTextStyle,
      titleLarge: TexteStyle().largeTextStyle,
      titleMedium: TexteStyle().secondaryTextStyle,
      titleSmall: TexteStyle().largeTextStyle,
    ),
    appBarTheme: const AppBarTheme(
        foregroundColor: ColorsApp.bgColor, backgroundColor: ColorsApp.bgColor),

    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(background: ColorsApp.bgColor)
        .copyWith(
          secondary: ColorsApp.primaryText,
        ),
  );
}
