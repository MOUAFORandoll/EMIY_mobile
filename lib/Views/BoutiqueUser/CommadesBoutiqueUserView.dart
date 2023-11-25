import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/app_bar_commande.dart';
import 'package:EMIY/components/Widget/app_bar_custom.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/commandeForComponent.dart';
import 'package:EMIY/components/Widget/produitBoutiqueComponent.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/Widget/app_back_button.dart';
import '../../components/Widget/app_title_right.dart';

class CommandesBoutiqueUserView extends StatelessWidget {
  CommandesBoutiqueUserView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    // Get.find<BoutiqueController>().getListCommandeForBoutique();
    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: AppBackButton(),
              actions: [
                Container(
                    margin: EdgeInsets.only(top: Get.height * .020),
                    padding: EdgeInsets.only(
                        left: Get.width * .030, right: Get.width * .030),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: AppTitleRight(
                                title: 'commandes'.tr,
                                description: ''.tr,
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ])),
              ]),
          body: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX),
                child: KTextField(
                    controllerField: _controller.searchInBoutiqueCont,
                    onChange: _controller.searchCommande,
                    onClear: _controller.onClearAllController)),
            _controller.isLoadedPC == 0
                ? AppLoading()
                : _controller.commandeBoutiqueList.length == 0
                    ? Container(
                        height: kHeight,
                        child: AppEmpty(title: 'Aucune Commande'))
                    : SingleChildScrollView(
                        child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.commandeBoutiqueList.length,
                        itemBuilder: (_ctx, index) {
                          return CommandeBoutiqueComponent(
                              commande:
                                  _controller.commandeBoutiqueList[index]);
                        },
                      ))
          ])));
    });
  }
}
