import 'package:Fahkap/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  String? hint;
  IconData? icon;
  TextInputType? type;
  TextEditingController? controller;
  Function(String)? onChange;
  Function? onTap;
  bool? obscureText;
  TextForm(
      {this.hint,
      this.icon,
      this.onChange,
      this.type,
      this.controller,
      this.obscureText = false,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String value) {
        if (onChange != null) onChange!(value);
      },
      controller: controller,
      validator: (value) {
        return value!.isEmpty ? "veillez remplir se champs" : null;
      },
      keyboardType: type,
      obscureText: obscureText!,
      decoration: new InputDecoration(
        fillColor: ColorsApp.skyBlue,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: ColorsApp.skyBlue,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: ColorsApp.skyBlue,
          ),
        ),
        contentPadding: EdgeInsets.only(
          left: 15,
          bottom: 11,
          top: 15,
          right: 15,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontFamily: 'orkney',
        ),
        suffixIcon: InkWell(
          onTap: () => onTap,
          child: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
