import 'package:EMIY/controller/searchController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
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
  final prefix;
  final String? type;
  Function? onChange;
  var onTap;
  final double? dim;
  bool isCode;

  KTextField(
      {Key? key,
      required this.controllerField,
      this.title,
      this.prefix,
      this.type,
      this.dim,
      this.isCode = false,
      this.onTap,
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
    return GetBuilder<SearchController>(builder: (searchCont) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorsApp.greySecond,
        ),

        height: kToolbarHeight / 1.7,
        // width: kMdWidth * 2,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onChanged: (String value) {
            if (onChange != null) onChange!(value);
          },

          keyboardType: _typekeyBord,
          // cursorRadius: const Radius.circular(20),
          // cursorHeight: kToolbarHeight / 2,

          // cursorColor: const Color(0xff28255A),
          cursorHeight: 30.0,
          controller: controllerField,
          obscureText: type == KFieldType.password,
          textAlign: TextAlign.left,

          decoration: InputDecoration(
            prefix: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorsApp.bgCont,
                ),
                height: searchCont.tsearch == 0 ? 0 : kToolbarHeight / 1.9,
                width: searchCont.tsearch == 0 ? 0 : kMdWidth * 0.5,
                margin: EdgeInsets.only(top: 10),
                child: searchCont.tsearch == 1
                    ? Icon(Icons.access_alarms_rounded)
                    : searchCont.tsearch == 2
                        ? Icon(Icons.ad_units)
                        : searchCont.tsearch == 3
                            ? Icon(Icons.ac_unit_outlined)
                            : null),
            hintText: isCode ? '1234' : 'Recherche',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.zero,
            ),
            suffixIcon: Container(
                child: InkWell(
                    child: Icon(
                      Icons.close,
                      color: ColorsApp.red,
                    ),
                    onTap: onTap)),
            contentPadding: EdgeInsets.symmetric(vertical: 10)
                .add(EdgeInsets.only(left: kMarginX)),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      );
    });
  }
}
