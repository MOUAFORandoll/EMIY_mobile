import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormPaiement extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  Function(String)? onChange;
  Function? onTap;
  bool border;
  bool border0;
  bool icon;
  FormPaiement(
      {this.border = false,
      this.border0 = false,
      this.icon = false,
      this.hintText,
      this.onChange,
      this.controller,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: border
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorsApp.skyBlue, width: 1),
                left: border0
                    ? BorderSide(color: ColorsApp.skyBlue, width: 1)
                    : BorderSide(
                        width: 0, color: Colors.white, style: BorderStyle.none),
              ),
            )
          : BoxDecoration(
              border: Border(
                left: border0
                    ? BorderSide(color: ColorsApp.skyBlue, width: 1)
                    : BorderSide(
                        width: 0, color: Colors.white, style: BorderStyle.none),
              ),
            ),
      // margin: EdgeInsets.only(top: 5),
      child: TextFormField(
        onChanged: (String value) {
          if (onChange != null) onChange!(value);
        },
        onTap: () {
          if (onChange != null) onChange;
        },
        onEditingComplete: () {
          if (onChange != null) onChange;
        },
        controller: controller,
        validator: (value) {
          return value!.isEmpty ? "veillez remplir se champs" : null;
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          fillColor: ColorsApp.skyBlue,
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //     borderSide: BorderSide(
          //       color: ColorsApp.skyBlue,
          //     )),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(
            left: 15,
            // bottom: 11,
            // top: 15,
            // right: 15,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12),
          labelText: hintText,
          labelStyle: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
          suffixIcon: InkWell(
            onTap: () => onTap,
            child: icon
                ? Icon(
                    Icons.payment,
                    color: Colors.grey,
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }
}
