import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Widget/Fieul.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/MySearchController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:EMIY/components/Button/AppIconButton.dart';
import 'package:EMIY/components/Button/IconButtonF.dart';
import 'package:EMIY/components/Button/customBtn.dart';
import 'package:EMIY/components/Text/SimpleText.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/bigtitleText0.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/controller/cartController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/controller/categoryBoutiqueController.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/model/data/ProduitModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/Services/routing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ParrainnageView extends StatelessWidget {
  ParrainnageView({
    Key? key,
  }) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
        builder: (manage) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Share.share(
                      'Inscris-toi avec mon lien et rejoins emiy : ' +
                          manage.lienParrainnage,
                      subject: 'Look what I made!');
                },
                child: Container(
                    child: IconButtonF(
                  color: ColorsApp.black,
                  icon: Icons.share,
                )),
              ),
              body: RefreshIndicator(
                color: ColorsApp.skyBlue,
                onRefresh: () async {
                  print('****debut');
                  await manage.getListFieul();
                  print('****mid');

                  print('****fin');
                },
                child: SafeArea(
                    child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
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
                                  margin:
                                      EdgeInsets.only(top: Get.height * .030),
                                  padding: EdgeInsets.only(
                                      left: Get.width * .030,
                                      right: Get.width * .030),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppBackButton(),
                                        Container(
                                          child: AppTitleRight(
                                              title: 'Parrainnage',
                                              description: 'Mes fieuls',
                                              icon: null),
                                          margin: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .005),
                                        ),
                                      ])),
                            ]),
                          ),
                        ),
                          expandedHeight: 60,
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        
                        (context, index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: kMarginX),
                          child: ListView.builder(
                              itemCount: manage.fieulList.length,
                              shrinkWrap: true,
                              // controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (_ctx, index) =>
                                  Fieul(fieul: manage.fieulList[index])),
                        ),
                        childCount: 1,
                      )),
                    ])),
              ),
              // bottomNavigationBar:
              //     GetBuilder<ProduitController>(builder: (prod) {
              //   return Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [],
              //   );
              // }),
            ));
  }
}
