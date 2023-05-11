import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/app_bar_commande.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/categoryComponent2.dart';
import 'package:Fahkap/components/Widget/commandeForComponent.dart';
import 'package:Fahkap/components/Widget/productBoutiqueComponent.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/controller/boutiqueController.dart';
import 'package:Fahkap/controller/categoryController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HistroriqueCBUView extends StatelessWidget {
  HistroriqueCBUView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerField = TextEditingController();

    Get.find<BoutiqueController>().getListHCommandeForBoutique();
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
        _controller.isLoadedPH == 0
            ? AppLoading()
            : _controller.HcommandeBoutiqueList.length == 0
                ? Container(
                    height: kHeight, child: AppEmpty(title: 'Aucune Commande'))
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
