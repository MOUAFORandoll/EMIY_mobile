import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:Fahkap/Views/FirstScreen.dart';
import 'package:Fahkap/utils/functions/route.dart';
import 'package:Fahkap/utils/provider/auth_provider.dart';
import 'package:Fahkap/views/UsersMange/LoginScreen.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  GetStorage box = GetStorage();
  bool isLogin = false;
 
  @override
  void initState() {
    super.initState();
      final userData = box.read(userKey);
    if (userData != null) {
      isLogin = true;
      reloader();
    }

    print(
        "$isLogin  finnnnnnnnnnnnnnnnnnnnnnnn-customDio.geietApiClient*****************************");
  }

  reloader() {
    const oneSec = const Duration(minutes: 20);
    if (box.read(firstKey) != null) {
      new Timer.periodic(
        oneSec,
        (Timer t) async {
          print(
              "--------------${box.read(firstKey)}--------customDio.geietApiClient*****************************");
          if (box.read(firstKey) != null) {
            // await CustomDio().getApiClient();
          }

          print(
              "finnnnnnnnnnnnnnnnnnnnnnnn-customDio.geietApiClient*****************************");

          final userData = box.read(userKey);
          if (userData != null) isLogin = true;
        },
      );
    }
  }

  reload(DioError error) {
    if (error.response?.statusCode == 401) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? FirstScreen() : LoginScreen();
  }
}
