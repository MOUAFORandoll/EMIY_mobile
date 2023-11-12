import 'package:EMIY/styles/textStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/managerController.dart';
import '../../styles/colorApp.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    var _manager = Get.find<ManagerController>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMarginX),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: kHeight * .02,
                        ),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  right: kWidth * .03,
                                ),
                                decoration: BoxDecoration(
                                    color: ColorsApp.secondBlue,
                                    borderRadius: BorderRadius.circular(30)
                                    /*   image: DecorationImage(
                                        image: AssetImage(
                                            "assets/logo/logoNew.png")) */
                                    ),
                                child: CircleAvatar(
                                    // backgroundColor: ColorsApp.skyBlue,
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage("assets/logo/logoNew.png"))),
                            Container(
                              child: Text(
                                'Emiy',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: kWidth * .5,
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorsApp.greyTi),
                    constraints: BoxConstraints(
                      maxWidth: kWidth * .50,
                    ),
                    padding: EdgeInsets.all(kMarginX),
                    margin: EdgeInsets.only(left: kMarginX * 2),
                    // width: kWidth * .58,
                    child: Text(message,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: ColorsApp.white,
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
