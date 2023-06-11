import 'package:EMIY/components/Text/smallText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/utils/Services/routing.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("AboutUs"),
      //   centerTitle: true,
      // ),
      body: Center(child: smallText(text: 'AboutUs')),
    );
  }
}
