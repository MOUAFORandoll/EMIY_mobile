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
              backgroundColor: ColorsApp.bg,
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
                        backgroundColor: ColorsApp.bg,
                        automaticallyImplyLeading: false,
                        title: Text(
                          'Mes Parrainnages',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Lato', fontWeight: FontWeight.w600),
                        ),
                        leading: Container(
                            child: InkWell(
                          child: Container(
                            margin: EdgeInsets.zero,
                            // padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(

                                // borderRadius: BorderRadius.circular(20),
                                ),
                            child: Icon(Icons.arrow_back_ios_new,
                                color: ColorsApp.black, size: 25.0),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        )),
                        pinned: true,
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
