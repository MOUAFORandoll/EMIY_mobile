import 'package:EMIY/Views/Space/Negociation/ListNegociationView.dart';
import 'package:EMIY/Views/Space/Notifications/NotificationView.dart';
import 'package:EMIY/components/Button/AppIconSendButton.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/Conversation.dart';
import 'package:EMIY/components/Widget/InputMessaage.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_tab_component.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/produitComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';

import '../../components/exportcomponent.dart';

class MySpace extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_general) {
      return Scaffold(
          body: SafeArea(
              child: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          // Provide a standard title.
          // title: Text('title'),
          // Allows the user to reveal the app bar if they begin scrolling
          // back up the list of items.
          floating: true,
          // Display a placeholder widget to visualize the shrinking size.
          flexibleSpace: InkWell(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: Get.height * .030),
                    padding: EdgeInsets.only(
                        left: Get.width * .030, right: Get.width * .030),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppBackButton(color: ColorsApp.black),
                          Container(
                            child: AppTitleRight(
                                title: _general.titleSpace,
                                description: "Vous avez 5 notifications",
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
            ),
          ),
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 155,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: kMarginX, vertical: kMarginY),
                padding: EdgeInsets.only(
                    left: Get.width * .030, right: Get.width * .030),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   height: kSmHeight / 1.2,
                      //   margin: EdgeInsets.symmetric(
                      //     vertical: kMarginY,
                      //   ),
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 3,
                      //     itemBuilder: (context, index) {
                      //       if (index == 0) {
                      //         return AppTabComponent(
                      //           libelle: 'Notifications',
                      //           selected: _general.spaceSelect == index,
                      //           onTap: () => _general.sectectSpace(index),
                      //         );
                      //       } else if (index == 1) {
                      //         return AppTabComponent(
                      //           libelle: 'Negociations',
                      //           selected: _general.spaceSelect == index,
                      //           onTap: () => _general.sectectSpace(index),
                      //         );
                      //       } else if (index == 2) {
                      //         return AppTabComponent(
                      //           libelle: 'Service Client',
                      //           selected: _general.spaceSelect == index,
                      //           onTap: () => _general.sectectSpace(index),
                      //         );
                      //       }
                      //       return Container(); // Ou tout autre widget par défaut au cas où l'index serait hors limites.
                      //     },
                      //   ),
                      // )
                      Container(
                          margin: EdgeInsets.symmetric(
                            vertical: kMarginY,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTabComponent(
                                  libelle: 'Notifications',
                                  selected: _general.spaceSelect == 0,
                                  onTap: () => _general.sectectSpace(0),
                                ),
                                AppTabComponent(
                                  libelle: 'Conversations',
                                  selected: _general.spaceSelect == 1,
                                  onTap: () => _general.sectectSpace(1),
                                ),
                                AppTabComponent(
                                  libelle: 'Service Client',
                                  selected: _general.spaceSelect == 2,
                                  onTap: () => _general.sectectSpace(2),
                                )
                              ]))
                    ])),
          ),

          pinned: true,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _general.buildSpace(),
                childCount: 1)),
        // if (_general.spaceSelect == 2)
        //   GetBuilder<ServiceClientController>(
        //     builder: (_sc) => SliverToBoxAdapter(
        //       child: Container(
        //         // height: 170,
        //         child: Row(
        //           children: [
        //             InputMessaage(
        //               controller: _sc.textEditingController,
        //             ),
        //             AppIconSendButton(
        //               icon: Icons.send,
        //               sending: _sc.sending,
        //               onTap: () => _sc.newMessageMessageEchange(),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
      ])));
    });
  }
}
