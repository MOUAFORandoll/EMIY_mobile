import 'package:EMIY/controller/MySearchController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

// ignore: must_be_immutable
class KSearchField extends StatelessWidget {
  final TextEditingController controllerField;
  final String? title;
  final prefix;
  final String? type;
  Function? onChange;
  final double? dim;
  bool isCode;

  KSearchField(
      {Key? key,
      required this.controllerField,
      this.title,
      this.prefix,
      this.type,
      this.dim,
      this.isCode = false,
      this.onChange})
      : super(key: key);
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(builder: (searchCont) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorsApp.greySecond,
        ),

        height: kToolbarHeight / 1.7,
        width: kMdWidth * 2,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onChanged: (String value) {
            if (onChange != null) onChange!(value);
          },
          focusNode: _focusNode,
          // cursorHeight: 30.0,
          controller: controllerField,
          // textAlign: TextAlign.left,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            prefixIcon: InkWell(
                onTap: () {
                  // searchCont.selectFilter();
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorsApp.greySearch,
                    ),
                    // height: searchCont.tsearch == 0 ? 0 : kToolbarHeight / 1.9,
                    width: kMdWidth * 0.7,
                    // margin: EdgeInsets.only(
                    //   left: 3,
                    // ).add(
                    //   EdgeInsets.symmetric(vertical: 0),
                    // ),

                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(child: Icon(Icons.settings)),
                        Container(
                            margin: EdgeInsets.only(left: 5),
                            child: searchCont.tsearch == 0
                                ? Text(
                                    'produit',
                                    style: TextStyle(
                                        color: ColorsApp.secondBlue,
                                        fontSize: 14),
                                  )
                                : searchCont.tsearch == 1
                                    ? Text(
                                        'boutique',
                                        style: TextStyle(
                                            color: ColorsApp.secondBlue,
                                            fontSize: 14),
                                      )
                                    : Text(
                                        'categorie',
                                        style: TextStyle(
                                            color: ColorsApp.secondBlue,
                                            fontSize: 14),
                                      ))
                      ],
                    ))),
            // suffix: searchCont.controllerField.text.length != 0
            //     ? InkWell(
            //         child: Container(
            //           // decoration: BoxDecoration(
            //           //   borderRadius: BorderRadius.circular(5),
            //           //   color: ColorsApp.greySearch,
            //           // ),
            //           // height: searchCont.tsearch == 0 ? 0 : kToolbarHeight / 1.9,
            //           //  width: searchCont.tsearch == 0 ? 0 : kMdWidth * 0.5,
            //           // margin: EdgeInsets.only(left: 3),
            //           margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            //           child: Icon(Icons.close),
            //         ),
            //         onTap: () {
            //           searchCont.searchType(0);
            //         },
            //       )
            //     : null,
            hintText: isCode ? '1234' : 'Recherche',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.zero,
            ),
            prefixStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            // contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
}
