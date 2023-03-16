import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/components/Button/themeButton.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //   Container(
            //       // padding: EdgeInsets.only(
            //       //   bottom: 25,
            //       // ),
            //       child: Icon(
            //     Icons.star,
            //     color: ColorsApp.skyBlue,
            //     size: 20,
            //   )),
            //   Container(
            //     child: ThemeButtonWidget(),
            //     margin: EdgeInsets.only(
            //         right: MediaQuery.of(context).size.width * .005),
            //   ),
            // ]),
            // new Hero(
            //   tag: "login screen",
            //   child: new Container(child: Image.asset('assets/login.png')),
            // ),
            Text(
              "Hi there !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
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
                    FormComponent(
                        icon: Icons.phone,
                        type: 0,
                        controller: phone,
                        enabled: true,
                        hint: "Phone"),
                    FormComponent(
                      icon: Icons.lock,
                      type: 1,
                      controller: password,
                      enabled: true,
                      hint: "Password",
                    )
                  ],
                )),
            GetBuilder<ManagerController>(
                builder: (_manager) => Button(
                    borderRadius: 15.0,
                    width: Get.size.height * .8,
                    margin:
                        EdgeInsets.only(top: Get.size.height * .025, bottom: 0),
                    height: Get.size.height * .08,
                    loaderColor: Colors.white,
                    title: "Connexion",
                    textColor: Colors.white,
                    itemColor: Colors.blue,
                    borderColor: Colors.transparent,
                    state: validator,
                    enabled: true,
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

            Center(
              child: TextButton(
                style: ButtonStyle(alignment: Alignment.center),
                child: Text('recuperer compte ?'),
                onPressed: () {
                  Get.toNamed(AppLinks.FORGOT);
                },
              ),
            )
            // Button(
            //     borderRadius: 15.0,
            //     width: Get.size.height * .8,
            //     margin: EdgeInsets.only(top: Get.size.height * .015, bottom: 0),
            //     height: Get.size.height * .08,
            //     loaderColor: Colors.white,
            //     title: "Create a new account",
            //     textColor: Colors.white,
            //     itemColor: Colors.black,
            //     borderColor: Colors.transparent,
            //     state: validator,
            //     enabled: true,
            //     onTap: () async {
            //       Get.toNamed(AppLinks.REGISTER);
            //     }),
            // Container(
            //   margin: EdgeInsets.only(top: Get.size.height * .008, bottom: 0),
            //   alignment: Alignment.center,
            //   child: TextButton(
            //     child: Text(
            //       'Forgot Password ?',
            //       textAlign: TextAlign.justify,
            //     ),
            //     onPressed: () => Get.toNamed(AppLinks.FORGOT),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
