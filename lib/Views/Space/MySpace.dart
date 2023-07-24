import 'package:EMIY/Views/Space/Negociation/ListNegociationView.dart';
import 'package:EMIY/Views/Space/NotificationView.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/Conversation.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/productComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MySpace extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(builder: (_action) {
      return DefaultTabController(
        length: 2, // Nombre total d'onglets
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            // backgroundColor: Colors.transparent,
            toolbarHeight: 50,
            flexibleSpace: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Notifications'),
                Tab(text: 'Message'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NotificationView(),
              ListNegociationView(),
            ],
          ),
        ),
      );
      // Builds 1000 ListTiles
    });
  }
}
