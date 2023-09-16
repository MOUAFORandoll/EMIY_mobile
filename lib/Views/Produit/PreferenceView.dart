import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/produitForBoutiqueComponent.dart';
import 'package:EMIY/controller/produitController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/Widget/app_empty.dart';

class PreferenceView extends StatelessWidget {
  PreferenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    return GetBuilder<ProduitController>(
      builder: (_controler) => Scaffold(
          body: SafeArea(
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
                        // margin: EdgeInsets.only(top: Get.height * .030),
                        padding: EdgeInsets.only(
                            left: Get.width * .030, right: Get.width * .030),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppBackButton(),
                              Container(
                                child: AppTitleRight(
                                    title: 'Mes Favories',
                                    description: ' ',
                                    icon: null),
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        .005),
                              ),
                            ])),
                  ]),
                ),
              ),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 60,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _controler.isLoadedPB == 0
                    ? AppLoading()
                    : Container(
                        // height: double.maxFinite,
                        margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                        child: _controler.isLoadedPB == 1
                            ? (_controler.preferenceList.length != 0)
                                ? SingleChildScrollView(
                                    child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kMarginX),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 20.0,
                                                childAspectRatio: 0.7,
                                                mainAxisSpacing: 20.0),
                                        itemCount:
                                            _controler.preferenceList.length,
                                        itemBuilder: (_ctx, index) =>
                                            ProduitForBoutiqueComponent(
                                                produit: _controler
                                                    .preferenceList[index],
                                                type: 'favorite',
                                                index: index)))
                                : Container(
                                    height: kHeight,
                                    child: AppEmpty(title: 'Aucun Produit'))
                            : Container(
                                height: kMdHeight * .6,
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text('Error'),
                                ))),
                childCount: 1,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
