import 'package:EMIY/styles/colorApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../exportcomponent.dart';

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
  final prefix;
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
      this.prefix,
      this.icon})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: kMarginY * 2,
        ),
        child: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: kMarginY / 2),
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                        color: ColorsApp.grey1, fontWeight: FontWeight.w500),
                  ),
                ],
              )),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: kHeight * .1,
            child: TextFormField(
              cursorColor: ColorsApp.secondBlue, autofocus: false,
              controller: widget.controller,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                // color: ColorsApp.secondBlue,
                fontSize: 12,
                fontFamily: 'Lato',
              ),

              // maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsApp.secondBlue, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.red, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.grey1, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    // borderSide:
                    //     BorderSide(color: ColorsApp.secondBlue, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorText: widget.errorText,
                  errorStyle: TextStyle(
                    fontFamily: 'Lato',
                  ),
                  prefixIcon: widget.prefix,
                  hintText: widget.placeholder,
                  suffixIcon: widget.icon),
              validator: widget.validator,
              obscureText: isVisible,
              keyboardType: widget.textInputType,
            ),
          )
        ]));
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
    return Padding(
        padding: EdgeInsets.only(
          top: kMarginY * 2,
        ),
        child: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: kMarginY / 2),
              child: Row(
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                        color: ColorsApp.grey1, fontWeight: FontWeight.w500),
                  ),
                ],
              )),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            height: kHeight * .1,
            child: TextFormField(
              autofocus: false,
              controller: widget.controller,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                // color: ColorsApp.secondBlue,
                fontSize: 15,
                fontFamily: 'Lato',
              ),
              cursorColor: ColorsApp.secondBlue,
              // maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsApp.secondBlue, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.red, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorsApp.grey1, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    // borderSide:
                    //     BorderSide(color: ColorsApp.secondBlue, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorText: widget.errorText,
                  errorStyle: TextStyle(
                    fontFamily: 'Lato',
                  ),
                  hintText: widget.placeholder,

                  // hintText: widget.placeholder,
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
          )
        ]));
  }
}
