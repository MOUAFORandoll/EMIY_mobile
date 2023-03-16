import 'package:Fahkap/components/Button/button.dart';
import 'package:Fahkap/components/Button/customBtn.dart';
import 'package:Fahkap/components/Form/formComponent.dart';
import 'package:Fahkap/controller/managerController.dart';
import 'package:Fahkap/styles/colorApp.dart';
import 'package:Fahkap/utils/Services/dependancies.dart';
import 'package:Fahkap/utils/functions/viewFunctions.dart';
import 'package:flutter/material.dart';

import 'package:Fahkap/utils/Services/routing.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  TextEditingController email = TextEditingController();

  bool validator = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // api.onInit();
  }

  var fn = new ViewFunctions();

  final int _numPages = 2;
  final pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  late TabController _tabController;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(
          i == _tabController.index ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 14.0 : 10,
      width: isActive ? 14.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.cyan : ColorsApp.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerController>(builder: (_manager) {
      return SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10),
              child: _manager.stateCreate
                  ? Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your Account',
                          // textAlign: TextAlign.justify,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Text(
                        //   "Sign Up here !",
                        //   // textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Text(
                        //   "Your Welcome.",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Container(
                            margin: EdgeInsets.only(
                                top: Get.size.height * .02,
                                bottom: Get.size.height * .025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            // padding: EdgeInsets.only(
                            //   top: 25,
                            // ),
                            child: Column(
                              children: [
                                FormComponent(
                                    icon: Icons.account_circle,
                                    type: 0,
                                    controller: name,
                                    enabled: true,
                                    hint: "Nom"),
                                FormComponent(
                                    icon: Icons.account_circle,
                                    type: 0,
                                    controller: surname,
                                    enabled: true,
                                    hint: "Prenom"),
                                // FormComponent(
                                //     icon: Icons.account_circle,
                                //     type: 0,
                                //     controller: phone,
                                //     enabled: true,
                                //     hint: "Ville"),
                                FormComponent(
                                    icon: Icons.phone,
                                    type: 0,
                                    controller: phone,
                                    enabled: true,
                                    hint: "Phone"),
                                // FormComponent(
                                //     icon: Icons.lock,
                                //     type: 1,
                                //     controller: pass,
                                //     enabled: true,
                                //     hint: "password"),
                                // FormComponent(
                                //     icon: Icons.lock,
                                //     type: 1,
                                //     controller: repass,
                                //     enabled: true,
                                //     hint: "repeat-password")
                              ],
                            )),
                        Button(
                            borderRadius: 15.0,
                            width: Get.size.height * .8,
                            margin: EdgeInsets.only(
                                top: Get.size.height * .025, bottom: 0),
                            height: Get.size.height * .08,
                            loaderColor: Colors.white,
                            title: "Next",
                            textColor: Colors.white,
                            itemColor: Colors.blue,
                            borderColor: Colors.transparent,
                            state: validator,
                            enabled: true,
                            onTap: () async {
                              _manager.steStateCreate();
                            }),
                        /*  Text(
                              "Confirm your register!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Enter security code.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                           */
                      ],
                    )
                  : Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Finish your Account',
                          // textAlign: TextAlign.justify,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: Get.size.height * .02,
                                bottom: Get.size.height * .025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            // padding: EdgeInsets.only(
                            //   top: 25,
                            // ),
                            child: Column(
                              children: [
                                // FormComponent(
                                //     icon: Icons.account_circle,
                                //     type: 0,
                                //     controller: phone,
                                //     enabled: true,
                                //     hint: "Code"),
                                FormComponent(
                                    icon: Icons.lock,
                                    type: 1,
                                    controller: pass,
                                    enabled: true,
                                    hint: "password"),
                                FormComponent(
                                    icon: Icons.lock,
                                    type: 1,
                                    controller: repass,
                                    enabled: true,
                                    hint: "repeat-password")
                              ],
                            )),
                        GetBuilder<ManagerController>(
                            builder: (_manager) => Button(
                                borderRadius: 15.0,
                                width: Get.size.height * .8,
                                margin: EdgeInsets.only(
                                    top: Get.size.height * .025, bottom: 0),
                                height: Get.size.height * .08,
                                loaderColor: Colors.white,
                                title: "S'inscrire",
                                textColor: Colors.white,
                                itemColor: Colors.blue,
                                borderColor: Colors.transparent,
                                state: validator,
                                enabled: true,
                                onTap: () async {
                                  if (pass.text != repass.text) {
                                    fn.snackBar(
                                        'Mot de passse',
                                        'Mot de passe differents',
                                        ColorsApp.red);
                                  } else {
                                    // Get.toNamed(AppLinks.FIRST);
                                    await _manager.signUp({
                                      'phone': phone.text,
                                      'password': pass.text,
                                      "nom": name.text,
                                      "prenom": surname.text,
                                      "email": email.text,
                                      "status": true,
                                    });
                                    if (_manager.isSignUp) {
                                      // Get.offNamedUntil(AppLinks.FIRST,
                                      //     (route) => false);

                                      MyBinding().onGetDataNew();
                                    }
                                  }
                                })),
                        Button(
                            borderRadius: 15.0,
                            width: Get.size.height * .8,
                            margin: EdgeInsets.only(
                                top: Get.size.height * .025, bottom: 0),
                            height: Get.size.height * .08,
                            loaderColor: Colors.white,
                            title: "Back",
                            textColor: Colors.white,
                            itemColor: Colors.grey,
                            borderColor: Colors.transparent,
                            state: validator,
                            enabled: true,
                            onTap: () async {
                              _manager.steStateCreate();
                            }),
                      ],
                    )));
    });
  }
}
