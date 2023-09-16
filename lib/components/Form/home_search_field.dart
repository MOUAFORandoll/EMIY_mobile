import 'package:EMIY/controller/MySearchController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

// ignore: must_be_immutable
class KHomeSearchField extends StatelessWidget {
  final TextEditingController controllerField;
  final String? title;
  final prefix;
  final String? type;
  Function? onChange;
  final double? dim;
  bool isCode;

  KHomeSearchField(
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
          height: kToolbarHeight / 1.7,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: kMdWidth * 1.9,

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
                      // contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),

                      hintText: isCode ? '1234' : 'Recherche',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorsApp.greySearch),
                        borderRadius: BorderRadius.circular(8),
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
                  )),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorsApp.black,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: ColorsApp.white,
                  ))
            ],
          ));
    });
  }
}
