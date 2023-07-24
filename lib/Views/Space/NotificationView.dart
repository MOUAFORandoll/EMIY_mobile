import 'package:EMIY/components/Text/bigtitleText.dart';
import 'package:EMIY/components/Text/smallText.dart';
import 'package:EMIY/components/Text/titleText.dart';
import 'package:EMIY/components/Widget/Conversation.dart';
import 'package:EMIY/components/Widget/app_loading.dart';
import 'package:EMIY/components/Widget/app_title_right.dart';
import 'package:EMIY/components/Widget/productComponent0.dart';
import 'package:EMIY/controller/CommandeController.dart';
import 'package:EMIY/controller/ActionController.dart';
import 'package:EMIY/model/data/CommandeModel.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:EMIY/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NotificationView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(builder: (_negociation) {
      return Text('ddd');

      // Builds 1000 ListTiles
    });
  }
}
