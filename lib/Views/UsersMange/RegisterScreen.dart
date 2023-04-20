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
    return Scaffold(body: GetBuilder<ManagerController>(builder: (_manager) {
      return SingleChildScrollView(
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
                            icon: Icons.account_circle_outlined),
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * .005),
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
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: kMarginY * 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('regText'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: kMarginY,
                            ),
                            child: AppInput(
                              controller: name,
                              icon: Icon(
                                Icons.check_circle_sharp,
                                // color: authCont.validMailLogin
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
                            padding: EdgeInsets.only(
                              top: kMarginY,
                            ),
                            child: AppInput(
                              controller: surname,
                              icon: Icon(
                                Icons.check_circle_sharp,
                                // color: authCont.validMailLogin
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
                            padding: EdgeInsets.only(
                              top: kMarginY,
                            ),
                            child: AppInput(
                              controller: email,
                              icon: Icon(
                                Icons.check_circle_sharp,
                                // color: authCont.validMailLogin
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
                            padding: EdgeInsets.only(
                              top: kMarginY,
                            ),
                            child: AppInput(
                              controller: phone,
                              icon: Icon(
                                Icons.check_circle_sharp,
                                // color: authCont.validMailLogin
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
                            padding: EdgeInsets.only(
                              top: kMarginY,
                            ),
                            child: AppInputPassword(
                              controller: pass,
                              label: 'labelpassword'.tr,
                              obscureText: true,
                              validator: (value) {
                                print('fdfdfd');
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kMarginY,
                            ),
                            child: AppInputPassword(
                              controller: pass,
                              label: 'labelpassword'.tr,
                              obscureText: true,
                              validator: (value) {
                                print('fdfdfd');
                              },
                            ),
                          ),
                          GetBuilder<ManagerController>(
                              builder: (_manager) => AppButton(
                                  size: MainAxisSize.max,
                                  bgColor: ColorsApp.skyBlue,
                                  text: 'regbtn'.tr,
                                  onTap: () async {
                                    if (pass.text != repass.text) {
                                      fn.snackBar('Mot de passse',
                                          'Mot de passe differents', false);
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
                        ],
                      )),
                )
              ])));
    }));
  }
}
