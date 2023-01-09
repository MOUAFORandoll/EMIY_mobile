import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:fahkapmobile/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class KFieldType {
  static String password = 'password';
  static String text = 'text';
  static String phone = 'phone';
  static String email = 'email';
}

// ignore: must_be_immutable
class KTextField extends StatelessWidget {
  final TextEditingController controllerField;
  final String? title;
  final String? type;
  Function? onChange;
  final double? dim;
  bool isCode;

  KTextField(
      {Key? key,
      required this.controllerField,
      this.title,
      this.type,
      this.dim,
      this.isCode = false,
      this.onChange})
      : super(key: key);

  get _typekeyBord {
    TextInputType? textType;
    if (type == null ||
        type == KFieldType.text ||
        type == KFieldType.password) {
      textType = TextInputType.text;
    } else if (type == KFieldType.phone) {
      textType = TextInputType.phone;
    } else if (type == KFieldType.email) {
      textType = TextInputType.emailAddress;
    }
    return textType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight / 1.7,
      width: kMdWidth * 2,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        onChanged: (String value) {
          if (onChange != null) onChange!(value);
        },

        keyboardType: _typekeyBord,
        // cursorRadius: const Radius.circular(20),
        // cursorHeight: kToolbarHeight / 2,

        cursorColor: const Color(0xff28255A),
        controller: controllerField,
        obscureText: type == KFieldType.password,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: isCode ? '1234' : '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintStyle: TextStyle(
              color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
