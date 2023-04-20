import 'package:Fahkap/components/Button/app_button.dart';
import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Button/themeButton.dart';
import 'package:Fahkap/components/Widget/app_back_button.dart';
import 'package:Fahkap/components/Widget/app_input.dart';
import 'package:Fahkap/components/Widget/app_title_right.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/styles/textStyle.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/Services/validators.dart';
import 'package:flutter/material.dart';

import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kMarginX),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(child: AppBackButton()),
              Container(
                child: AppTitleRight(
                    title: 'Login',
                    description: 'Welcome dear',
                    icon: Icons.account_circle_outlined),
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * .005),
              ),
            ]),
            new Hero(
              tag: "login screen",
              child: new Container(child: Image.asset('assets/login.png')),
            ),
            Text(
              "logtext".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   "Your Welcome.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Container(
                margin: EdgeInsets.only(
                    top: Get.size.height * .02, bottom: Get.size.height * .025),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                // padding: EdgeInsets.only(
                //   top: 25,
                // ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: kMarginY,
                      ),
                      child: AppInput(
                        controller: phone,
                        icon: Icon(
                          Icons.check_circle_sharp,
                          // color: Validators.validMailLogin
                          //     ? AppColors.primaryGreen
                          //     : AppColors.grayColor,
                        ),
                        onChanged: (value) {
                          // authCont.validMailLoginU(!(Validators.isValidEmail(
                          //         authCont.emailController.text) ==
                          //     'invalidMail'.tr));
                        },
                        label: 'labellog'.tr,
                        validator: (value) {
                          //  int.parse(authCont.emailController.text)
                          // return Validators.isValidEmail(
                          //     authCont.emailController.text);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: kMarginY * 2,
                      ),
                      child: AppInputPassword(
                        controller: password,
                        label: 'labelpassword'.tr,
                        obscureText: true,
                        // valid: authCont
                        //         .passwordController.text.length >=
                        //     8,
                        validator: (value) {
                          print('fdfdfd');
                          // return Validators.required('labelpassword'.tr,
                          //     authCont.passwordController.text);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: kMarginY),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppLinks.FORGOT);
                            },
                            child: Text('forgotpass'.tr,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                )),
                          )
                        ],
                      ),
                    ),
                    GetBuilder<ManagerController>(
                        builder: (_manager) => AppButton(
                            size: MainAxisSize.max,
                            bgColor: ColorsApp.skyBlue,
                            text: 'logbtn'.tr,
                            onTap: () async {
                              // Get.toNamed(AppLinks.FIRST);
                              print({
                                'phone': phone.text,
                                'password': password.text,
                              });
                              await _manager.loginUser({
                                'phone': phone.text,
                                'password': password.text,
                              });
                              if (_manager.isConnected) {
                                // Get.offNamedUntil(AppLinks.FIRST, (route) => false);

                                MyBinding().onGetDataNew();
                              }
                            })),
                    Container(
                      margin: EdgeInsets.only(bottom: kMarginY),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppLinks.REGISTER);
                            },
                            child: Text('regbtn'.tr,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
