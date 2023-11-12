import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/model/socket/NegociationModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/functions/formatData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Conversation extends StatelessWidget {
  Conversation({required this.negociation});

  final NegociationModel negociation;

  @override
  Widget build(BuildContext context) {
    var formatData = new FormatData();
    return InkWell(
      onTap: () async {
        Get.toNamed(AppLinks.NEGOCIATION_NEW);
        await Get.find<NegociationController>()
            .getListMessageNegociation(negociation);
      },
      child: Container(
          decoration: BoxDecoration(
              // color: ColorsApp.red,
              border: Border(
            bottom: BorderSide(color: ColorsApp.greySecond),
          )),
          padding: EdgeInsets.symmetric(vertical: kMarginY / 2)
              .add(EdgeInsets.only(bottom: kMarginY)),
          margin: EdgeInsets.symmetric(
            horizontal: kMarginX * 1.5,
            vertical: kMarginY / 2,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kWidth / 7,
                  width: kWidth / 7,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: negociation.src_produit,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                          decoration: BoxDecoration(
                        color: ColorsApp.greySecond,
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.transparent, BlendMode.colorBurn)),
                      ));
                    },
                    placeholder: (context, url) {
                      return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: ColorsApp.skyBlue,
                        )),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                          height: kHeight / 4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/logo/logoNew.png'),
                          )));
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: kMarginX,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: kWidth * .55,
                                  child: Text(
                                    formatData.capitalizeFirstLetter(
                                        negociation.titre_produit),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                    width: kWidth * .4,
                                    child: Text(
                                      negociation.last_message,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      // softWrap: true,
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        color: ColorsApp.greyTi,
                                      ),
                                    )),
                              ]),
                          Container(
                              child: Text(
                            negociation.date,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            // softWrap: true,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: ColorsApp.black,
                            ),
                          )),
                        ])),
              ])),

      //  Column(
      //   children: [
      //     ListTile(
      //       leading: CircleAvatar(
      //         radius: 30,
      //         child: CachedNetworkImage(
      //           fit: BoxFit.cover,
      //           imageUrl: negociation.src_produit,
      //           imageBuilder: (context, imageProvider) {
      //             return Container(
      //                 decoration: BoxDecoration(
      //               color: ColorsApp.greySecond,
      //               borderRadius: BorderRadius.circular(30),
      //               image: DecorationImage(
      //                   image: imageProvider,
      //                   fit: BoxFit.cover,
      //                   colorFilter: ColorFilter.mode(
      //                       Colors.transparent, BlendMode.colorBurn)),
      //             ));
      //           },
      //           placeholder: (context, url) {
      //             return Container(
      //               child: Center(
      //                   child: CircularProgressIndicator(
      //                 color: ColorsApp.skyBlue,
      //               )),
      //             );
      //           },
      //           errorWidget: (context, url, error) {
      //             return Container(
      //                 height: kHeight / 4,
      //                 decoration: BoxDecoration(
      //                     image: DecorationImage(
      //                   image: AssetImage('assets/logo/logoNew.png'),
      //                 )));
      //           },
      //         ),
      //         backgroundColor: Colors.blueGrey,
      //       ),
      //       title: Text(
      //         negociation.titre_produit,
      //         style: TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //       subtitle: Row(
      //         children: [
      //           Icon(Icons.done_all),
      //           SizedBox(
      //             width: 3,
      //           ),
      //           Container(
      //               width: kWidth * .5,
      //               child: Text(
      //                 negociation.last_message,
      //                 textAlign: TextAlign.start,
      //                 overflow: TextOverflow.ellipsis,
      //                 softWrap: true,
      //                 style: TextStyle(
      //                     fontFamily: 'Lato',
      //                     fontSize: 12,
      //                     color: ColorsApp.black,
      //                     fontWeight: FontWeight.w600),
      //               )),
      //         ],
      //       ),
      //       trailing: Text(negociation.date),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(right: 20, left: 80),
      //       child: Divider(
      //         thickness: 1,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
