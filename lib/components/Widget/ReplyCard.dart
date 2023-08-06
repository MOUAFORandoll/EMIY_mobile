import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';

import '../../styles/colorApp.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              margin: EdgeInsets.only(
                bottom: kHeight * .1,
                left: kWidth * .03,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircleAvatar(
                    // backgroundColor: ColorsApp.skyBlue,
                    radius: 10,
                    backgroundImage: AssetImage("assets/logo/logo.png")),
              ])),
          Container(
            margin: EdgeInsets.only(
              bottom: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Emiy',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.blueAccent,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 50,
                            top: 5,
                            bottom: 10,
                          ),
                          child: Container(
                              constraints: BoxConstraints(
                                maxWidth: kWidth * .45,
                              ),
                              margin: EdgeInsets.only(left: kMarginX * .6),
                              // width: kWidth * .58,
                              child: Text(message,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    overflow: TextOverflow.fade,
                                    color: ColorsApp.black,
                                  ))),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 10,
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
