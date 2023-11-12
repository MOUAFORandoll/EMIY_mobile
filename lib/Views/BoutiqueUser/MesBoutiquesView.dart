import 'package:EMIY/components/Text/TextBackSpace.dart';
import 'package:EMIY/components/Widget/MyBoutiqueComponent.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:shimmer/shimmer.dart';

class MesBoutiquesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoutiqueController>(
      builder: (_bcontroller) {
        return Scaffold(
            backgroundColor: ColorsApp.bg,
            body: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: ColorsApp.bg,
                automaticallyImplyLeading: false,
                title: Container(
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
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        decoration: BoxDecoration(
                          color: ColorsApp.bg,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: kWidth * .010),
                                      child: TextBackSpace(
                                        text: 'Mes Boutiques',
                                        // bolder: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]))),
                expandedHeight: 100,
                pinned: true,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: kMarginX),
                    // margin: EdgeInsets.only(top: kMarginY),
                    // height: kHeight / 2.2,
                    // constraints: BoxConstraints(maxHeight: kHeight / 2),
                    // decoration: BoxDecoration(
                    //     color: AppColors.red, borderRadius: BorderRadius.circular(20)),
                    child: _bcontroller.loadBoutique
                        ? Shimmer.fromColors(
                            baseColor: ColorsApp.grey,
                            highlightColor: Colors.blueGrey,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 4,
                                itemBuilder: (_ctx, index) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    constraints: BoxConstraints(
                                        minHeight: kHeight / 10,
                                        minWidth: kWidth / 2.4),
                                    width: kWidth,
                                    decoration: BoxDecoration(
                                        color: ColorsApp.greySecond,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: kMdHeight * .15,
                                              width: Get.width * .5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/logo/logoNew.png'),
                                              ))),
                                        ]))))
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            //   crossAxisSpacing: 8.0,
                            //   childAspectRatio: 1.1,
                            //   mainAxisSpacing: 15.0,
                            // ),
                            itemCount: _bcontroller.listBoutiques.length,
                            itemBuilder: (_ctx, index) => InkWell(
                                  child: MyBoutiqueComponent(
                                    boutique: _bcontroller.listBoutiques[index],
                                  ),
                                  onTap: () => _bcontroller.selectBoutique(
                                      _bcontroller.listBoutiques[index]),
                                ))),
                childCount: 1,
              ))
            ]));
      },
    );
  }
}
