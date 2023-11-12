import 'package:EMIY/controller/MySearchController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class KSearchFieldGeneral extends StatelessWidget {
  final TextEditingController controllerField;

  var width;
  final ValueChanged<String>? onChange;

  KSearchFieldGeneral(
      {required this.controllerField, this.width, this.onChange});
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
        width: width ?? kWidth * .75,

        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onChanged: onChange,
          focusNode: _focusNode,
          // cursorHeight: 30.0,
          controller: controllerField,
          // textAlign: TextAlign.left,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            prefixIcon: Icon(Icons.search),
            suffixIcon: searchCont.tsearch == 0
                ? null
                : InkWell(
                    onTap: () {
                      searchCont.clearAll();
                    },
                    child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(15),
                        //   color: ColorsApp.greySearch,
                        // ),
                        child: Icon(Icons.close))),

            hintText: 'Recherche',
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
