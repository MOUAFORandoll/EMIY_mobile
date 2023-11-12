import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/Conversation.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/produitComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/negociationController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../components/Form/search_field.dart';
import '../../../components/Form/search_field_general.dart';

class ListNegociationView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NegociationController>(builder: (_negociation) {
      return _negociation.isLoadNego == 0
          ? AppLoading()
          : Column(
              children: [
                InkWell(
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: kMarginY * 1.5),
                        child: KSearchFieldGeneral(
                          width: kWidth * .9,
                          controllerField: _negociation.searchNegoController,
                          onChange:  (value) =>
                                                           _negociation.searchNego(),
                        ))),
                SingleChildScrollView(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemCount: _negociation.listNegociation.length,
                        itemBuilder: (_ctx, x) => Conversation(
                            negociation: _negociation.listNegociation[x]))),
              ],
            );

      /*     ])  childCount: 1,
        ))
      ]); */

      // Builds 1000 ListTiles
    });
  }
}
