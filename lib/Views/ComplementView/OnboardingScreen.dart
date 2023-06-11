import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Widget/app_carroussel_item.dart';
import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:EMIY/utils/constants/assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class OnBoardingView extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(
        builder: (action) => Scaffold(
                // appBar: AppBar(
                //   title: const Text('Agora Video Call'),
                // ),

                body: SingleChildScrollView(
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: action.controller,
                    items: [
                      AppCarrousselItem(
                        title: 'ctitle1'.tr,
                        description: 'cdescription1'.tr,
                        image: Assets.onb1,
                      ),
                      AppCarrousselItem(
                          title: 'ctitle2'.tr,
                          description: 'cdescription2'.tr,
                          image: Assets.onb2,
                          index: action.index),
                      AppCarrousselItem(
                        title: 'ctitle3'.tr,
                        description: 'cdescription3'.tr,
                        image: Assets.onb3,
                      )
                    ],
                    options: CarouselOptions(
                        aspectRatio: 4 / 4,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        onPageChanged: (index, reason) {
                          action.setIndex(index);
                        },
                        disableCenter: true,
                        height: Get.height,
                        // enlargeCenterPage: true,
                        // autoPlay: true,

                        // autoPlayCurve: Curves.fastOutSlowIn,
                        // enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal),
                  ),
                  Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: action.index == 2
                          ? Column(
                              children: [
                                Container(
                                  // margin: EdgeInsets.all(kMarginX)
                                  //     .add(EdgeInsets.only(bottom: 10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: ['0', '1', '2']
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                          onTap: () {
                                            action.controller.animateToPage(
                                              entry.key,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                          child: Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: (Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : ColorsApp.skyBlue)
                                                    .withOpacity(action.index ==
                                                            entry.key
                                                        ? 0.9
                                                        : 0.2)),
                                          ));
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(kMarginX),
                                    //     .add(EdgeInsets.only(bottom: 10)),
                                    child: AppButton(
                                      size: MainAxisSize.max,
                                      bgColor: ColorsApp.black,
                                      text: 'start'.tr,
                                      onTap: () async {
                                        Get.offNamedUntil(
                                            AppLinks.FIRST, (route) => false);
                                      },
                                    ))
                              ],
                            )
                          : Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      margin: (EdgeInsets.only(bottom: 15)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Colors.white).withOpacity(0.5),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.offAndToNamed(
                                            Get.find<ManagerController>()
                                                        .User ==
                                                    null
                                                ? AppLinks.LOGIN
                                                : AppLinks.FIRST,
                                          );
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Skip',
                                                  style: TextStyle(
                                                      color: action.index == 0
                                                          ? Colors.white
                                                          : ColorsApp.black,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                      )),
                                  Container(
                                    margin: EdgeInsets.all(kMarginX)
                                        .add(EdgeInsets.only(bottom: 15)),
                                    padding: EdgeInsets.all(kMarginX / 3.2),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: ['0', '1', '2']
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        return GestureDetector(
                                            onTap: () {
                                              action.controller.animateToPage(
                                                entry.key,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            child: Container(
                                              width: 8.0,
                                              height: 8.0,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: (Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : ColorsApp.skyBlue)
                                                      .withOpacity(
                                                          action.index ==
                                                                  entry.key
                                                              ? 0.9
                                                              : 0.2)),
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                      margin: (EdgeInsets.only(bottom: 15)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          action.index == 2
                                              ? Get.offNamedUntil(
                                                  AppLinks.FIRST,
                                                  (route) => false)
                                              : action.controller.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.linear,
                                                );
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  padding: (EdgeInsets.only(
                                                      bottom: 3)),
                                                  child: Text('Next',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                                size: 25,
                                                color: ColorsApp.black,
                                              ),
                                            ]),
                                      )),
                                ],
                              ),
                            )),
                ],
              ),
            )));
  }
}
