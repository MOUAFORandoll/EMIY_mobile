import 'package:EMIY/components/Button/app_button.dart';
import 'package:EMIY/components/Widget/Fieul.dart';
import 'package:EMIY/components/Widget/app_back_button.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/controller/GeneralController.dart';
import 'package:EMIY/controller/searchController.dart';
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
import 'package:rating_bar/rating_bar.dart';

import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ParrainnageView extends StatelessWidget {
  ParrainnageView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
      builder: (manage) => Container(
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
    );
  }
}
