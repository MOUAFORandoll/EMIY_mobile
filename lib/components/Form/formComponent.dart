import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormComponent extends StatefulWidget {
  FormComponent(
      {this.type, this.controller, this.enabled, this.icon, this.hint});

  final controller;
  bool? enabled = false;

  ///type = 0 => texte simple ; type = 1 =>password
  int? type = 0;
  String? hint = '';
  var icon;
  @override
  _FormComponentState createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        return value == "" ? "veillez remplir se champs" : null;
      },
      enabled: widget.enabled,
      onChanged: (val) {
        setState(() {
          value = val;
        });

        print('value');
        print(value);
      },
      keyboardType: TextInputType.text,
      obscureText: widget.type == 1 ? true : false,
      decoration: new InputDecoration(
        prefixIcon: Icon(widget.icon),
        counterText: "",
        // focusedBorder: OutlineInputBorder(
        //     // borderRadius: BorderRadius.circular(15),
        //     borderSide: BorderSide(
        //   color: (value.isNotEmpty)
        //       ? (/* !(RegExp(r'^(0|[1-9]\d*)$')
        //                                       .hasMatch(value.text) && */
        //               value.length != 9)
        //           ? Colors.red
        //           : Colors.blue
        //       : Colors.blue,
        // )),
        border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.only(
          left: 15,
          bottom: 11,
          top: 15,
          right: 15,
        ),

        hintText: widget.hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
