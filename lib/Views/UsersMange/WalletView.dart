import 'package:EMIY/components/Widget/TransactionComponent.dart';
import 'package:EMIY/controller/TransactionController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class WalletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      builder: (transControll) => transControll.isLoadedTrans == 0
          ? /* Shimmer.fromColors(
                              baseColor: Colors.blueGrey,
                              highlightColor: Colors.greenAccent,
                              child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (_ctx, x) => Container(
                                  height: kMdHeight * .13,
                                  width: kMdWidth,
                                  // padding: EdgeInsets.all(kMarginX),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: kMarginX, vertical: kMarginY),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  alignment: Alignment.center,
                                                  // margin: EdgeInsets.only(left: Get.width * .008),
                                                  child: Icon(
                                                      Icons.transit_enterexit))
                                            ]),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                // width: kSmWidth * .6,
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: BigtitleText0(
                                                  text: 'Transaction :  ',
                                                  bolder: true,
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: SimpleText(
                                                    text: 'Montant : XAF ')),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: SimpleText(
                                                  text: 'Fait le :  ',
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: Get.height * .005,
                                                    left: Get.width * .008),
                                                child: SimpleText(
                                                    text: 'Etat : ')),
                                            // Container(
                                            //   width: kSmWidth * .6,
                                            //   margin: EdgeInsets.only(
                                            //       top: Get.height * .005, left: Get.width * .008),
                                            //   child: Text('XAF ' + price.toString(),
                                            //       overflow: TextOverflow.ellipsis,
                                            //       style: TextStyle(
                                            //           decoration: TextDecoration.lineThrough,
                                            //           decorationColor:  ColorsApp.black,
                                            //           decorationThickness: 2.85,
                                            //           color:  ColorsApp.black,
                                            //           fontSize: 12,
                                            //           fontWeight: FontWeight.w600)),
                                            // ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ))
                           */
          SpinKitCircle(
              color: Colors.blue,
              size: 40,
            )
          : Container(
              height: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
              child: ListView.builder(
                itemCount: transControll.transactionList.length,
                // controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => TransactionComponent(
                  transaction: transControll.transactionList[index],
                ),
              ),
            ),
    );
  }
}
