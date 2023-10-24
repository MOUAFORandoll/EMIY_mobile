import 'package:EMIY/Views/Short/SingleShortView.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/ShortController.dart';
import 'package:EMIY/model/socket/NotificationModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NotificationComponent extends StatelessWidget {
  NotificationModel notification;

  NotificationComponent({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          // Get.to(goTo(notification.type_notification));
          open();
          await Get.find<GeneralController>().readNotification(notification.id);
          await Get.find<ShortController>().disposePLayerAll();
        },
        child: Container(
            margin: EdgeInsets.symmetric (vertical: kMarginY/2, horizontal: kMarginX*2),
            decoration: !notification.read
                ? BoxDecoration(
                    color: ColorsApp.greySearch,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorsApp.greySearch),
                  )
                : null,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                height: kWidth / 6,
                width: kWidth / 6,
                padding: EdgeInsets.all(3),

                // decoration: BoxDecoration(color: ColorsApp.black),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: notification.profile,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                            decoration: BoxDecoration(
                          color: ColorsApp.greySecond,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: ColorsApp.greySecond),
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
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: ColorsApp.greySecond,
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/logo/logoNew.png'),
                                )));
                      },
                    ),
                    if (notification.type_notification == 1)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                // borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: Colors.red),
                                ),
                            child: Icon(FontAwesomeIcons.sun,
                                color: Colors.red, size: 14)),
                      ),
                    if (notification.type_notification == 2)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                // borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: Colors.red),
                                ),
                            child: Icon(Icons.favorite,
                                color: Colors.red, size: 14)),
                      ),
                    if (notification.type_notification == 3)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                // borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: Colors.red),
                                ),
                            child: Icon(FontAwesomeIcons.comment,
                                color: Colors.red, size: 12)),
                      ),
                    if (notification.type_notification == 4)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                // borderRadius: BorderRadius.circular(30),
                                // border: Border.all(color: Colors.red),
                                ),
                            child: Icon(Icons.favorite,
                                color: Colors.red, size: 14)),
                      ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: kMarginY/4)
                      .add(EdgeInsets.only(left: kMarginX)),
                  padding:
                      EdgeInsets.only(top: kMarginY / 2, bottom: kMarginY * 3),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  notification.title,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                  width: kWidth * .6,
                                  child: Text(
                                    notification.description,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    // softWrap: true,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      color: ColorsApp.greyTi,
                                    ),
                                  )),
                              Container(
                                  child: Text(
                                calculerDifference(notification.date),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                // softWrap: true,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12,
                                  color: ColorsApp.greyTi,
                                ),
                              )),
                            ]),
                      ])),
            ])));
  }

  String calculerDifference(String value) {
    // Convertir la date en DateTime
    DateTime date = DateTime.parse(value);

    // Obtenir la date actuelle
    DateTime dateActuelle = DateTime.now();

    // Calculer la différence en secondes
    int differenceEnSecondes = dateActuelle.difference(date).inSeconds;
    String resultat = '';
    // Tableau des unités de temps et de leurs valeurs en secondes

    print('---${value}-------${differenceEnSecondes}');

    if (differenceEnSecondes < 60) {
      resultat = "$differenceEnSecondes  s";
    }
    if (differenceEnSecondes >= 60 && differenceEnSecondes < 3600) {
      var cal = (differenceEnSecondes / 60).toString().split('.')[0];
      resultat = "${int.parse(cal)}  min";
    }
    if (differenceEnSecondes >= 3600 && differenceEnSecondes < 86400) {
      var cal = (differenceEnSecondes / 3600).toString().split('.')[0];
      resultat = "${int.parse(cal)}  hr";
    }
    if (differenceEnSecondes >= 86400 && differenceEnSecondes < 2629800) {
      var cal = (differenceEnSecondes / 86400).toString().split('.')[0];
      resultat = "${int.parse(cal)}  jr";
    }
    if (differenceEnSecondes >= 2629800 && differenceEnSecondes < 31536000) {
      var cal = (differenceEnSecondes / 2629800).toString().split('.')[0];
      resultat = "${int.parse(cal)}  mois";
    }
    if (differenceEnSecondes >= 31536000) {
      var cal = (differenceEnSecondes / 31536000).toString().split('.')[0];
      resultat = "${int.parse(cal)}  an";
    }

    return resultat;
  }

  var fn = new ViewFunctions();
  open() async {
    fn.loading('', '');
    await Get.find<ShortController>().getUniqueShort(notification.short, null);

    Get.back();
    Get.to(SingleShortView(
      idShort: notification.short,
    ));
  }

  goTo(type) {
    switch (type) {
      case 2:
        return SingleShortView(
          idShort: notification.short,
        );
      case 3:
        return SingleShortView(
          idShort: notification.short,
        );

      case 4:
        return SingleShortView(
          idShort: notification.short,
        );

      default:
        return 0;
    }
  }
}
