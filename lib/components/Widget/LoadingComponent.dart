import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:Fahkap/styles/colorApp.dart';

class LoadingComponent {
  Future<void> openLoadingDialog() async {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(10),
        content: Container(
          height: 50,
          width: 0,
          child: SpinKitCircle(
              // strokeWidth: 5,
              color: Colors.blue),
        ),
      ),
      barrierDismissible: false,
    );
    // await Future.delayed(Duration(seconds: 3));
    // Get.back();
  }

  Widget data = Container(
      margin: EdgeInsets.only(top: Get.height * .5),
      alignment: Alignment.center,
      child: SpinKitCircle(
        color: ColorsApp.bleuLight,
      ));
}
