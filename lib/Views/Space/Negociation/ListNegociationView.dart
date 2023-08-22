import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/Conversation.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/produitComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ListNegociationView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NegociationController>(builder: (_negociation) {
      return _negociation.isLoadNego == 0
          ? AppLoading()
          : /* CustomScrollView(controller: _scrollController, slivers: [
     SliverAppBar(
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
                    margin: EdgeInsets.only(top: Get.height * .030),
                    padding: EdgeInsets.only(
                        left: Get.width * .030, right: Get.width * .030),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // BigtitleText(text: 'Category', bolder: true),
                          Container(
                            child: AppTitleRight(
                                title: 'Message',
                                description: 'liste des messages',
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                          // Container(
                          //     child: InkWell(
                          //         child: Icon(Icons.search),
                          //         onTap: () => Scaffold.of(context).openDrawer())
                          //     // padding: EdgeInsets.only(right: 10),
                          //     ),
                        ])),
              ]),
            ),
            /*   onTap: () => filterDest() */
          ),
          // Make the initial height of the SliverAppBar larger than normal.
          expandedHeight: 60,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          
          (context, index) => */
          SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  itemCount: _negociation.listNegociation.length,
                  itemBuilder: (_ctx, x) => Conversation(
                      negociation: _negociation.listNegociation[x])));

      /*     ])  childCount: 1,
        ))
      ]); */

      // Builds 1000 ListTiles
    });
  }
}
