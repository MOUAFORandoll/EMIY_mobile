import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Button/themeButton.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:flutter/material.dart';

import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';

class BoutiqueBuyView extends StatefulWidget {
  BoutiqueBuyView({Key? key}) : super(key: key);

  @override
  _BoutiqueBuyViewState createState() => _BoutiqueBuyViewState();
}

class _BoutiqueBuyViewState extends State<BoutiqueBuyView> {
  TextEditingController titre = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validator = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          body: CustomScrollView(
              // controller: _scrollController,
              slivers: [
            // Add the app bar to the CustomScrollView.
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.zero,
                      // padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(

                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 25.0),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              )),
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      decoration: BoxDecoration(
                        gradient: GradientApp.blueG,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: kMdHeight * .08,
                                width: kMdWidth * 1.2,
                                // margin: EdgeInsets.symmetric(
                                //     horizontal: kMarginX * 10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(8),
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  //  Border.all(color: borderColor),
                                  color: Colors.white,

                                  // gradient: GradientApp.blueG,
                                ),
                                child: Text(
                                  'Loyer Boutique'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ]))),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 2, bottom: 3),
                                  height: 3,
                                  width: kMdWidth * .5,
                                  decoration: BoxDecoration(
                                      gradient: GradientApp.blueG,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Container())
                            ])
                      ])),
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  width: double.maxFinite,
                ),
              ),
              expandedHeight: 120,
              pinned: true,
            ),
            SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Column(children: [
                    SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payer le loyer de votre boutique !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Center(
                          //   child: TextButton(
                          //     style: ButtonStyle(alignment: Alignment.center),
                          //     child: Text('recuperer boutique ?'),
                          //     onPressed: () {
                          //       Get.toNamed(AppLinks.FORGOT);
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ))
                  ])),
              childCount: 1,
            ))
          ]));
    });
  }
}
