import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/CommandeComponent.dart';
import 'package:EMIY/components/Widget/OwnMessgaeCrad.dart';
import 'package:EMIY/components/Widget/ReplyCard.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/productComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ServiceClientController.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ServiceClientView extends StatelessWidget {
  ServiceClientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceClientController>(builder: (_sc) {
      return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                CustomScrollView(
                  // controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                              decoration: BoxDecoration(
                                color: ColorsApp.bleuLight,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: kWidth / 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              child: Container(
                                                margin: EdgeInsets.zero,
                                                decoration: BoxDecoration(),
                                                child: Icon(
                                                    Icons.arrow_back_ios_new,
                                                    color: Colors.white,
                                                    size: 20.0),
                                              ),
                                              onTap: () {
                                                Get.back();
                                              },
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsApp.textBlue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                // margin: EdgeInsets.symmetric(
                                                //     horizontal: kWidth / 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons
                                                            .supervised_user_circle,
                                                        color: ColorsApp.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'service client',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorsApp.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              child: Icon(
                                                Icons.call,
                                                color: ColorsApp.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]))),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 3),
                                          height: 3,
                                          width: kMdWidth * .5,
                                          decoration: BoxDecoration(
                                              gradient: GradientApp.blueG,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Container())
                                    ])
                              ])),
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          width: double.maxFinite,
                        ),
                      ),
                      expandedHeight: 150,
                      pinned: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                          // padding: EdgeInsets.only(
                          //   top: 20,
                          // ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _sc.scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _sc.listMessageEchange.length,
                            itemBuilder: (context, index) {
                              if (index == _sc.listMessageEchange.length) {
                                return Container(
                                  height: 70,
                                );
                              }
                              if (_sc.listMessageEchange[index].emetteurId ==
                                  _sc.idUser) {
                                return OwnMessageCard(
                                  message:
                                      _sc.listMessageEchange[index].message,
                                  time: _sc.listMessageEchange[index].heure,
                                );
                              } else {
                                return ReplyCard(
                                  message:
                                      _sc.listMessageEchange[index].message,
                                  time: _sc.listMessageEchange[index].heure,
                                );
                              }
                            },
                          ),
                        ),
                        childCount: 1,
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //     child: Container(
                    //   color: Colors.red,
                    //   height:
                    //       50.0, // Adjust the height according to your needs
                    //   child: Center(
                    //     child: Text('This is the persistent 0000'),
                    //   ),
                    // )
                    //     // pinned: true,
                    //     // floating: false,
                    //     ),
                  ],
                )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              // (Get.find<BoutiqueController>().Boutique != null)
              //     ? IconButton(
              //         icon: Icon(Icons.quora),
              //         onPressed: () {
              //           _sc.newMessageMessageEchange();
              //         },
              //       )
              //     : Container(),
              Expanded(
                child: TextField(
                  controller: _sc.textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Entrez votre message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _sc.newMessageMessageEchange();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _CustomPersistentFooterDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.red,
      height: 50.0, // Adjust the height according to your needs
      child: Center(
        child: Text('This is the persistent footer'),
      ),
    );
  }

  @override
  double get maxExtent =>
      50.0; // Adjust the maxExtent to match the height of the footer

  @override
  double get minExtent =>
      50.0; // Adjust the minExtent to match the height of the footer

  @override
  bool shouldRebuild(_CustomPersistentFooterDelegate oldDelegate) {
    return false;
  }
}
  /***
   *  Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  (Get.find<BoutiqueController>()
                                              .Boutique !=
                                          null)
                                      ? IconButton(
                                          icon: Icon(Icons.quora),
                                          onPressed: () {
                                            _sc.newMessageMessageEchange();
                                          },
                                        )
                                      : Container(),
                                  Expanded(
                                    child: TextField(
                                      controller: _sc.textEditingController,
                                      decoration: InputDecoration(
                                        hintText: 'Entrez votre message...',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () {
                                      _sc.newMessageMessageEchange();
                                    },
                                  ),
                                ],
                              ),
                          ),
   */