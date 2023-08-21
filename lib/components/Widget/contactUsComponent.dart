import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

class ContactUsButton extends StatefulWidget {
  @override
  _ContactUsButtonState createState() => _ContactUsButtonState();
}

class _ContactUsButtonState extends State<ContactUsButton> {
  Color icon = ColorsApp.secondBlue;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.sms_outlined),
      onPressed: () {},
    );
  }
}
