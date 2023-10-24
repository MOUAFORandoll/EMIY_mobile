import 'package:EMIY/components/Widget/Fieul.dart';
import 'package:EMIY/controller/managerController.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
