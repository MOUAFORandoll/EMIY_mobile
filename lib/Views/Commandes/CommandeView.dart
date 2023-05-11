import 'package:Fahkap/components/Button/btnCatList.dart';
import 'package:Fahkap/components/Button/btnCatListPV.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent2.dart';
import 'package:Fahkap/components/Text/bigText.dart';
import 'package:Fahkap/components/Text/bigtitleText.dart';
import 'package:Fahkap/components/Widget/CommandeComponent.dart';
import 'package:Fahkap/components/Widget/app_back_button.dart';
import 'package:Fahkap/components/Widget/app_empty.dart';
import 'package:Fahkap/components/Widget/app_loading.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/components/Widget/categoryComponent.dart';
import 'package:Fahkap/components/Widget/categoryComponent2.dart';
import 'package:Fahkap/components/Widget/productComponent.dart';
import 'package:Fahkap/components/Text/smallText.dart';
import 'package:Fahkap/components/Text/titleText.dart';
import 'package:Fahkap/controller/CommandeController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CommandeView extends StatelessWidget {
  CommandeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommandeController>(builder: (_commande) {
      return Scaffold(
          body: CustomScrollView(controller: _scrollController, slivers: [
        SliverList(

            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
          // The builder function returns a ListTile with a title that
          // displays the index of the current item.
          (context, index) => _commande.isLoaded == 0
              ? AppLoading()
              : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(bottom: kMarginY * 2),
                    decoration: BoxDecoration(color: ColorsApp.grey),
                    padding: EdgeInsets.only(
                        left: kMdWidth / 6,
                        right: kMdWidth / 6,
                        top: kMarginY * 2.2,
                        bottom: kMarginY * 2.2),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: AppBackButton()),
                          Container(
                            child: AppTitleRight(
                                title: 'ycom'.tr,
                                description: 'yscom'.tr,
                                icon: null),
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * .005),
                          ),
                        ]),
                  ),
                  _commande.commandeList.length == 0
                      ? Container(
                          height: kHeight,
                          child: AppEmpty(title: 'Aucune Commande'))
                      : Container(
                          height: kMdHeight,
                          margin: EdgeInsets.symmetric(vertical: kMarginY * .2),
                          child: ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            itemCount: _commande.commandeList.length,
                            itemBuilder: (_ctx, index) =>
                                _commande.commandeList[index].id != null
                                    ? CommandeComponent(
                                        commande: _commande.commandeList[index],
                                      )
                                    : Text(''),
                          ),
                        )
                ]),

          childCount: 1, //_commande.commandeList.length,
        ))
      ]));
    });
  }
}
