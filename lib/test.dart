import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  ScrollController _scrollController = new ScrollController();

  getH() {
    print(1 + Random().nextInt(6 - 2));
    return int.parse((1 + Random().nextInt(6 - 2)).toString());
  }

  List<double> list = [18.0, 10, 9, 5, 18.5, 7.5, 3.9];
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: GetBuilder<ActionController>(builder: (action) {
          return Button(
            title: 'Ass',
            onTap: () {
              var a = getH();
              print('dd');
              action.notificationSnackBar('teste ${a}', a);
            },
          );
        })),
      ),
    );
  }
}
