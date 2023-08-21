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

class MySpace extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_general) {
      return Scaffold(
          body: SafeArea(
              child: CustomScrollView(controller: _scrollController, slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,

          elevation: 0,
          centerTitle: false,
          leading: IconButtonF(
            icon: Icons.arrow_back_ios_new,
            color: ColorsApp.black,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),

          // flexibleSpace: PreferredSize(
          //   preferredSize: Size.fromHeight(100), // Set the fixed height here
          //   child: Container(
          //     margin: EdgeInsets.only(top: 53, left: 0)
          //         .add(EdgeInsets.symmetric(horizontal: kMarginX)),
          //     padding: EdgeInsets.only(
          //         left: Get.width * .030, right: Get.width * .030),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //             child: Text('Notifications',
          //                 style: TextStyle(
          //                     fontFamily: 'Montserrat',
          //                     color: ColorsApp.black,
          //                     fontWeight: FontWeight.w700,
          //                     fontSize: 16))),
          //         Container(
          //             child: Text('Vous avez 5 notifications',
          //                 style: TextStyle(
          //                     fontFamily: 'Montserrat',
          //                     color: ColorsApp.greyFirst,
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 12))),
          //       ],
          //     ),
          //   ),
          // ),

          // Make the initial height of the SliverAppBar larger than normal.
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
                margin: EdgeInsets.only(left: 0)
                    .add(EdgeInsets.symmetric(horizontal: kMarginX)),
                padding: EdgeInsets.only(
                    left: Get.width * .030, right: Get.width * .030),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text('Notifications',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ColorsApp.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16))),
                      Container(
                          child: Text('Vous avez 5 notifications',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ColorsApp.greyFirst,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12))),
                      Container(
                        height: kSmHeight / 1.2,
                        margin: EdgeInsets.symmetric(
                          vertical: kMarginY,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return AppTabComponent(
                                libelle: 'Notifications',
                                selected: _general.spaceSelect == index,
                                onTap: () => _general.sectectSpace(index),
                              );
                            } else if (index == 1) {
                              return AppTabComponent(
                                libelle: 'Negociations',
                                selected: _general.spaceSelect == index,
                                onTap: () => _general.sectectSpace(index),
                              );
                            } else if (index == 2) {
                              return AppTabComponent(
                                libelle: 'Service Client',
                                selected: _general.spaceSelect == index,
                                onTap: () => _general.sectectSpace(index),
                              );
                            }
                            return Container(); // Ou tout autre widget par défaut au cas où l'index serait hors limites.
                          },
                        ),
                      )
                    ])),
          ),
          expandedHeight: 70,
          floating: false,
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
