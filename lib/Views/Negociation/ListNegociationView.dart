import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/components/Widget/Conversation.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/components/Widget/productComponent0.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/controller/negociationController.dart';
import 'package:Fahkap/model/data/CommandeModel.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ListNegociationView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NegociationController>(builder: (_negociation) {
      return Scaffold(
          body: RefreshIndicator(
              color: ColorsApp.skyBlue,
              onRefresh: () async {
                //print('****debut');
                // await Get.find<CategoryBoutiqueController>().getCategory();
                //print('****mid');

                //print('****fin');
              },
              child: CustomScrollView(controller: _scrollController, slivers: [
                // Add the app bar to the CustomScrollView.
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
                                left: Get.width * .030,
                                right: Get.width * .030),
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
                                            MediaQuery.of(context).size.width *
                                                .005),
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
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildBuilderDelegate(
                      // The builder function returns a ListTile with a title that
                      // displays the index of the current item.
                      (context, index) => SingleChildScrollView(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              itemCount: _negociation.listNegociation.length,
                              itemBuilder: (_ctx, x) => Conversation(
                                  negociation:
                                      _negociation.listNegociation[x]))),

                 childCount: 1,
                ))
              ])));

      // Builds 1000 ListTiles
    });
  }
}
