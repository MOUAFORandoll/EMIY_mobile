import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

route(context, widget, {bool close = false}) {
  return close
      ? Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => widget), (route) => false)
      : Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget));
}

final String userKey = "user";
final String userInfo = "userInfo";
final String firstKey = "firstKey";

class Variable {
  static String ?token;
  static String? refreshToken;
}
 