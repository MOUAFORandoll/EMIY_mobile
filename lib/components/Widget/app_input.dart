import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class AppInput extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? errorText;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? textInputType;
  final Icon? icon;
  const AppInput(
      {Key? key,
      required this.controller,
      required this.label,
      this.validator,
      this.placeholder,
      this.errorText,
      this.onChanged,
      this.obscureText = false,
      this.textInputType,
      this.icon})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: kHeight / 10,
      child: TextFormField(
        autofocus: false,
        controller: widget.controller,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Lato',
        ),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.skyBlue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              //  borderSide : BorderSide(color:Colors.blue,width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              fontSize: 8,
              fontFamily: 'Lato',
            ),
            labelText: widget.label,
            labelStyle: TextStyle(
              color: ColorsApp.black, fontFamily: 'Lato',
              // fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            hintText: widget.placeholder,
            prefixIcon: widget.icon),
        validator: widget.validator,
        keyboardType: widget.textInputType,
      ),
    );
  }
}

class AppInputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? errorText;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  // final bool valid;
  final TextInputType? textInputType;
  const AppInputPassword({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    // this.valid = false,
    this.placeholder,
    this.errorText,
    this.onChanged,
    this.obscureText = false,
    this.textInputType,
  }) : super(key: key);

  @override
  State<AppInputPassword> createState() => _AppInputPasswordState();
}

class _AppInputPasswordState extends State<AppInputPassword> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: kHeight / 10,
      child: TextFormField(
        autofocus: false,
        controller: widget.controller,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: 'Lato',
          fontSize: 14,
        ),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorsApp.skyBlue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              //  borderSide : BorderSide(color:Colors.blue,width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            errorText: widget.errorText,
            errorStyle: TextStyle(
              fontSize: 8,
              fontFamily: 'Lato',
            ),
            labelText: widget.label,
            labelStyle: TextStyle(
              color: ColorsApp.black, fontFamily: 'Lato',
              // fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            hintText: widget.placeholder,
            suffixIcon: widget.obscureText == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible
                          ? Icons.remove_red_eye
                          : CupertinoIcons.eye_slash,
                      /*     */
                    ),
                  )
                : null),
        validator: widget.validator,
        obscureText: isVisible,
        keyboardType: widget.textInputType,
      ),
    );
  }
}
