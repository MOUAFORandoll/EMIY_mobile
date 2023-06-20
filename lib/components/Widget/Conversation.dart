import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/model/socket/NegociationModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Conversation extends StatelessWidget {
  Conversation({required this.negociation});

  final NegociationModel negociation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.toNamed(AppLinks.NEGOCIATION_NEW);
        await Get.find<NegociationController>()
            .getListMessageNegociation(negociation);
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: kMarginY)
              .add(EdgeInsets.only(left: kMarginX)),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: kWidth / 6,
              width: kWidth / 6,
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
                        image: AssetImage('assets/logo/logo.png'),
                      )));
                },
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: kMarginY)
                    .add(EdgeInsets.only(left: kMarginX)),
                padding:
                    EdgeInsets.only(top: kMarginY / 2, bottom: kMarginY * 3),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: ColorsApp.greySecond),
                        top: BorderSide(color: ColorsApp.greySecond))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                negociation.titre_produit,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                                width: kWidth * .6,
                                child: Text(
                                  negociation.last_message,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: ColorsApp.black,
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
                          fontFamily: 'Montserrat',
                          fontSize: 12,
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
      //                   image: AssetImage('assets/logo/logo.png'),
      //                 )));
      //           },
      //         ),
      //         backgroundColor: Colors.blueGrey,
      //       ),
      //       title: Text(
      //         negociation.titre_produit,
      //         style: TextStyle(
      //           fontSize: 16,
      //           fontWeight: FontWeight.bold,
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
      //                     fontFamily: 'Montserrat',
      //                     fontSize: 12,
      //                     color: ColorsApp.black,
      //                     fontWeight: FontWeight.bold),
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
