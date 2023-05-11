// ignore: must_be_immutable import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/components/Form/text_field.dart';
import 'package:Fahkap/model/data/CategoryModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarCommande extends StatelessWidget {
  String title;
  var onTap;
  bool search;
  var onChange;
  TextEditingController controllerField;
  AppBarCommande(
      {required this.controllerField,
      required this.title,
      required this.onTap,
      required this.search,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return !search
        ? Container(
            decoration: BoxDecoration(
                color: ColorsApp.grey, borderRadius: BorderRadius.circular(9)),
            padding: EdgeInsets.only(left: kMdWidth / 10, top: 2, bottom: 2),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: Get.size.width * 0.6,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontFamily: 'orkney',
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 11),
                      )),
                  Container(
                      width: Get.size.width * 0.2,

                      // margin: EdgeInsets.only(bottom: kMarginY),
                      child: InkWell(
                          child: Container(
                              // margin: EdgeInsets.only(right: 10),
                              child: !search
                                  ? Icon(
                                      Icons.search,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )),
                          onTap: onTap))
                ]))
        : KTextField(controllerField: controllerField, onChange: onChange, onTap: onTap);
  }
}
