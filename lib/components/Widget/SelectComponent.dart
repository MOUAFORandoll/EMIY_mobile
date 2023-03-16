import 'dart:async';

import 'package:Fahkap/controller/ActionController.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/model/data/ModePaiementModel.dart';
import 'package:Fahkap/styles/textStyle.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class SelectComponent extends StatelessWidget {
  SelectComponent({required this.select, required this.mode});
  bool select = false;
  ModePaiementModel mode;
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(
        builder: (_Acontroller) => InkWell(
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: select ? ColorsApp.skyBlue : Colors.white,
                              border: Border.all(color: ColorsApp.skyBlue),
                              borderRadius: BorderRadius.circular(20))),
                      Container(
                          height: 40,
                          margin: EdgeInsets.only(left: kMarginX * 10),
                          child: CachedNetworkImage(
                            width: kMdWidth / 2,
                            height: 40,
                            fit: BoxFit.cover,
                            imageUrl: mode.img,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    /* colorFilter: ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn) */
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) {
                              return Container(
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: ColorsApp.skyBlue,
                                )),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Text(mode.libelle);
                            },
                          )),
                    ],
                  )),
              onTap: () {
                _Acontroller.selectMode(mode.id);
              },
            ));
  }
}
