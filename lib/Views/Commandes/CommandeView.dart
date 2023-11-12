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
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/Text/TextBackSpace.dart';

class CommandeView extends StatelessWidget {
  CommandeView({Key? key}) : super(key: key);
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommandeController>(
      builder: (_commande) {
        return Scaffold(
            backgroundColor: ColorsApp.bg,
            body: CustomScrollView(controller: _scrollController, slivers: [
              SliverAppBar(
                backgroundColor: ColorsApp.bg,
                automaticallyImplyLeading: false,
                title: Text(
                  'Mes Commandes',
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
                (context, index) => _commande.isLoaded == 0
                    ? AppLoading()
                    : _commande.commandeList.length == 0
                        ? Container(
                            height: kHeight / 2,
                            child: AppEmpty(title: 'Aucune Commande'))
                        : ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            // controller: scrollController,
                            itemCount: _commande.commandeList.length,
                            itemBuilder: (_ctx, index) => CommandeComponent(
                              commande: _commande.commandeList[index],
                            ),
                          ),
                childCount: 1,
              ))
            ]));
      },
    );
  }
}
