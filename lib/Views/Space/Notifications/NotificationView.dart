import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/Conversation.dart';
import 'package:EMIY/components/Widget/NotificationComponent.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/produitComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotificationView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_general) {
      return _general.isLoadNotification == 0
          ? AppLoading()
          : SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _general.controllerScrollNotification,
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: _general.notificationList.length,
                  itemBuilder: (_ctx, x) =>
                      (x == _general.notificationList.length - 1 &&
                              _general.loaddata)
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              child: CircularProgressIndicator())
                          : NotificationComponent(
                              notification: _general.notificationList[x])),
            );

      // Builds 1000 ListTiles
    });
  }
}
