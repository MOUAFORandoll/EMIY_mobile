import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class AppInputNew extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? errorText;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool border;
  final TextInputType? textInputType;
  final bool alignStart;
  final Icon? icon;
  AppInputNew(
      {required this.controller,
      required this.label,
      this.validator,
      this.placeholder,
      this.errorText,
      this.onChanged,
      this.obscureText = false,
      this.border = false,
      this.alignStart = true,
      this.textInputType,
      this.icon});

  @override
  State<AppInputNew> createState() => _AppInputNewState();
}

class _AppInputNewState extends State<AppInputNew> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: kHeight / 10,
      child: TextFormField(
        autofocus: false,
        textAlign: widget.alignStart ? TextAlign.start : TextAlign.center,
        controller: widget.controller,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            focusedBorder: !widget.border
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.skyBlue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            border: widget.border
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              fontSize: 8,
              fontFamily: 'Montserrat',
            ),
            labelText: widget.label,
            labelStyle: TextStyle(
              color: ColorsApp.black, fontFamily: 'Montserrat',
              // fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            hintText: widget.placeholder,
            prefixIcon: widget.icon),
        validator: widget.validator,
        obscureText: isVisible,
        keyboardType: widget.textInputType,
      ),
    );
  }
}
