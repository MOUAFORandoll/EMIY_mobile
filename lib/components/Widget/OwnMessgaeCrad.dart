import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(
                  bottom: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'User',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: ColorsApp.secondBlue, // Color(0xffdcf8c6),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 30,
                                top: 5,
                                bottom: 20,
                              ),
                              child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: kWidth * .50,
                                  ),
                                  margin: EdgeInsets.only(left: kMarginX * .6),
                                  // width: kWidth * .58,
                                  child: Text(message,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        overflow: TextOverflow.fade,
                                        color: ColorsApp.white,
                                      ))),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 10,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  // Icon(
                                  //   Icons.done_all,
                                  //   size: 20,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(
                  bottom: kHeight * .1,
                  left: kWidth * .03,
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                      // backgroundColor: ColorsApp.skyBlue,
                      radius: 10,
                      backgroundImage: AssetImage("assets/om.png")),
                ])),
          ],
        ),
      ),
    );
  }
}
