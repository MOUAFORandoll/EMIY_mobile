import 'package:EMIY/components/Button/btnCatList.dart';
import 'package:EMIY/components/Button/btnCatListPV.dart';
import 'package:EMIY/components/Button/button.dart';
import 'package:EMIY/components/Form/formComponent2.dart';
import 'package:EMIY/components/Text/bigText.dart';
import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Widget/CommandeComponent.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_empty.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/categoryComponent.dart';
import 'package:EMIY/components/Widget/categoryComponent2.dart';
import 'package:EMIY/components/Widget/produitComponent.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CommandeView extends StatelessWidget {
  CommandeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommandeController>(builder: (_commande) {
      return _commande.isLoaded == 0
          ? AppLoading()
          : _commande.commandeList.length == 0
              ? Container(
                  height: kHeight / 2,
                  child: AppEmpty(title: 'Aucune Commande'))
              : ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: _commande.commandeList.length,
                  itemBuilder: (_ctx, index) =>
                      _commande.commandeList[index].id != null
                          ? CommandeComponent(
                              commande: _commande.commandeList[index],
                            )
                          : Text(''),
                );
    });
  }
}
