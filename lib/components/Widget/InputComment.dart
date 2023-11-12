import 'package:EMIY/components/exportcomponent.dart';
import 'package:flutter/material.dart';

class InputComment extends StatelessWidget {
  InputComment(
      {this.type,
      this.typeT,
      this.userTag,
      this.controller,
      this.enabled,
      this.focusNode,
      this.icon,
      this.hint});
  final focusNode;
  final controller;
  bool? enabled = false;
  // final String? title;
  final String? typeT;
  final String? userTag;

  ///type = 0 => texte simple ; type = 1 =>password
  int? type = 0;
  String? hint = '';
  var icon;
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kWidth * .66,
      height: 40,
      margin: EdgeInsets.symmetric(
        horizontal: 4,
        // top: 2,
      ),
      // decoration: BoxDecoration(boxShadow: [
      // BoxShadow(
      // color: ColorsApp.greySecond, spreadRadius: 1, blurRadius: 5)
      // ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: TextField(
        controller: controller,
        enabled: enabled,
        focusNode: focusNode,
        keyboardType: TextInputType.multiline,
        decoration: new InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12),
          labelText: hint,
          labelStyle: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 12),
          // prefix: userTag != null && userTag!.length != 0 && userTag != ''
          //     ? Text(
          //         '@' + userTag!,
          //         style: TextStyle(
          //             color: Colors.blue,
          //             fontWeight: FontWeight.w600,
          //             fontSize: 12),
          //       )
          //     : null,

          counterText: "",
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.blue,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),

            // borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),

          // hintText: hint,
          // hintStyle: TextStyle(
          //   color: Colors.grey,
          // ),
        ),
      ),
    );
  }
}
