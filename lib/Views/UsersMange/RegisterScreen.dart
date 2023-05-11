import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Widget/app_back_button.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/validators.dart';
import 'package:Fahkap/utils/constants/assets.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';

import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(
        builder: (_manager) => Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: kMarginX),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(child: AppBackButton()),
                            Container(
                              child: AppTitleRight(
                                  title: 'regbtn'.tr,
                                  description: 'Welcome dear',
                                  icon: Assets.user),
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * .005),
                            ),
                          ]),
                      Container(
                          padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: Get.size.height * .02,
                                bottom: Get.size.height * .025),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // padding: EdgeInsets.only(
                            //   top: 25,
                            // ),
                            child: Form(
                                key: _manager.formKeyReg,
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: kMarginY * 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('regText'.tr,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      child: AppInput(
                                        controller: _manager.name,
                                        label: 'labelname'.tr,
                                        validator: (value) {
                                          return Validators.isValidUsername(
                                              value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      child: AppInput(
                                        controller: _manager.surname,
                                        label: 'labelsurname'.tr,
                                        validator: (value) {
                                          return Validators.isValidUsername(
                                              value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      child: AppInput(
                                        controller: _manager.email,
                                        label: 'labelemail'.tr,
                                        validator: (value) {
                                          return Validators.isValidEmail(value);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      child: AppInput(
                                        controller: _manager.phone,
                                        label: 'labelphone'.tr,
                                        validator: (value) {
                                          return Validators.usPhoneValid(
                                              value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: kMarginY,
                                      ),
                                      child: AppInputPassword(
                                        controller: _manager.pass,
                                        label: 'labelpassword'.tr,
                                        obscureText: true,
                                        validator: (value) {
                                          return Validators.isValidPassword(
                                              value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: kMarginY,
                                      ),
                                      child: AppInputPassword(
                                        controller: _manager.repass,
                                        label: 'labelrpassword'.tr,
                                        obscureText: true,
                                        validator: (value) {
                                          return Validators.isValidRePassword(
                                              _manager.repass.text !=
                                                  _manager.pass.text);
                                        },
                                      ),
                                    ),
                                    GetBuilder<ManagerController>(
                                        builder: (_manager) => AppButton(
                                            size: MainAxisSize.max,
                                            text: 'regbtn'.tr,
                                            onTap: () async {
                                              if (_manager
                                                  .formKeyReg.currentState!
                                                  .validate()) {
                                                await _manager.signUp();
                                                if (_manager.isSignUp) {
                                                  MyBinding().onGetDataNew();
                                                }
                                              }
                                            })),
                                  ],
                                )),
                          ))
                    ])))));
  }
}
