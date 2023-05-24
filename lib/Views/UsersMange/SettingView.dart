import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Fahkap/components/Widget/settingComponent.dart';
import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  SettingView({
    Key? key,
  }) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  TextEditingController montant = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
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
                              'setting'.tr,
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
                child: Column(
                  children: [
                    SettingComponent(
                        title: 'Sombre',
                        action: GetBuilder<ActionController>(
                            builder: (actionControl) => Switch(
                                value: actionControl.dark,
                                onChanged: (val) {
                                  actionControl.changeTheme();
                                })),
                        onTap: () {}),
                    SettingComponent(
                        title: "Langue de l'application",
                        action: Container(
                          // width: kSmWidth * .6,
                          // margin: EdgeInsets.only(
                          //     top: Get.height * .005,
                          //     left: Get.width * .008),
                          height: 1500,
                          child: GetBuilder<ActionController>(
                            builder: (actionControl) => DropdownButton<String>(
                                value: actionControl.lang.value,
                                icon: Container(
                                  // padding: EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color(0xff1A90FF),
                                  ),
                                ),
                                iconSize: 25,
                                underline: SizedBox(),
                                style: TextStyle(
                                    color: Color(
                                      0xff1A90FF,
                                    ),
                                    fontSize: 20),
                                onChanged: (newValue) {
                                  actionControl.updateLanguage(newValue ?? '');
                                },
                                items: <String>[
                                  ...actionControl.locale.map((e) => e['name'])
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Center(
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Color(0xff1A90FF),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                        onTap: () {}),
                    SettingComponent(
                        title: 'Creer une boutique',
                        action: InkWell(
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                        onTap: () {
                          Get.find<BoutiqueController>().getCategory();
                          Get.toNamed(AppLinks.BOUTIQUE_NEW);
                        }),
                    SettingComponent(
                        title: 'Payer loyer boutique',
                        action: InkWell(
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                        onTap: () {
                          ViewFunctions().showIndisponible();
                          // Get.toNamed(AppLinks.BOUTIQUE_LOYER);
                        }),
                    SettingComponent(
                        title: 'Politique de confidentialite',
                        action: InkWell(
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        onTap: () {
                          Get.toNamed(AppLinks.POLITIQUE);
                        }),
                    SettingComponent(
                        title: "Aide et assistance",
                        action: InkWell(
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        onTap: () {
                          ViewFunctions().showIndisponible();
                          // Get.toNamed(AppLinks.HELP);
                        }),
                  ],
                )),
            childCount: 1,
          ),
        ),
      ],
    ));
  }
}
