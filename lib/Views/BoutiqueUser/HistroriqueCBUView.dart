import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Form/text_field.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/app_bar_commande.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/commandeForComponent.dart';
import 'package:EMIY/components/Widget/produitBoutiqueComponent.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/boutiqueController.dart';
import 'package:EMIY/controller/categoryController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HistroriqueCBUView extends StatelessWidget {
  HistroriqueCBUView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    return GetBuilder<BoutiqueController>(builder: (_controller) {
      return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: kMarginX),
            child: AppBarCommande(
                title: 'Historique des ventes',
                controllerField: _controller.controllerFieldSearch,
                onTap: () {
                  _controller.searchButtom();
                },
                search: _controller.searchCom,
                onChange: _controller.searchCommande)),
        _controller.loadFinishCommande == 0
            ? AppLoading()
            : _controller.HcommandeBoutiqueList.length == 0
                ? Container(
                    height: kHeight, child: AppEmpty(title: 'Aucune Vente'))
                : SingleChildScrollView(
                    child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _controller.HcommandeBoutiqueList.length,
                    itemBuilder: (_ctx, index) {
                      return CommandeBoutiqueComponent(
                          commande: _controller.HcommandeBoutiqueList[index]);
                    },
                  ))
      ]));
    });
  }
}
