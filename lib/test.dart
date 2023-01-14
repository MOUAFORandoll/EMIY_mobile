import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fahkapmobile/components/Text/bigtitleText.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
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
    return double.parse((1 + Random().nextInt(6 - 2)).toString());
  }

  List<double> list = [18.0, 10, 9, 5, 18.5, 7.5, 3.9];
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) =>
              // CachedNetworkImage(
              //   // fit: BoxFit.cover,
              //   imageUrl: 'https://via.placeholder.com/150',
              //   imageBuilder: (context, imageProvider) {
              //     return Container(
              //       decoration: BoxDecoration(
              //         color: ColorsApp.greySecond,
              //         borderRadius: BorderRadius.circular(8),
              //         image: DecorationImage(
              //             image: imageProvider,
              //             fit: BoxFit.cover,
              //             colorFilter: ColorFilter.mode(
              //                 Colors.red, BlendMode.colorBurn)),
              //       ),
              //     );
              //   },
              //   placeholder: (context, url) {
              //     return Container(
              //       child: Center(
              //           child: CircularProgressIndicator(
              //         color: ColorsApp.skyBlue,
              //       )),
              //     );
              //   },
              //   errorWidget: (context, url, error) {
              //     return Container(
              //         height: kMdHeight * .15,
              //         width: Get.width * .5,
              //         decoration: BoxDecoration(
              //             color: ColorsApp.greySecond,
              //             borderRadius: BorderRadius.circular(8),
              //             image: DecorationImage(
              //               image: AssetImage('assets/logo.png'),
              //             )));
              //   },
              // ),
              Container(
            child: Container(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Nom*'),
                        Text('1500F'),
                      ],
                    )),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ))),
          ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 3 : 2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 6.0,
        ),
      ),
    );
  }
}
