import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Form/formComponent.dart';
import 'package:fahkapmobile/components/Button/themeButton.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  bool enable1 = true;
  bool enable2 = true;

  bool enabled = false;
  // GetStorage box = GetStorage();
  bool validator = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        body: SingleChildScrollView(
            child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    // padding: EdgeInsets.only(
                    //   bottom: 25,
                    // ),
                    child: Icon(
                  Icons.star,
                  color: ColorsApp.skyBlue,
                  size: 20,
                )),
                Container(
                  child: ThemeButtonWidget(),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * .005),
                ),
              ]),
              new Hero(
                tag: "login screen",
                child: new Container(child: Image.asset('assets/login.png')),
              ),
              Text(
                "Hi there !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Your Welcome.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: Get.size.height * .025,
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
                          controller: phone,
                          enabled: true,
                          hint: "Phone"),
                      FormComponent(
                        icon: Icons.lock,
                        type: 1,
                        controller: phone,
                        enabled: true,
                        hint: "Password",
                      )
                    ],
                  )),
              Button(
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
                    Get.toNamed(AppLinks.FIRST);
                  }),
              Button(
                  borderRadius: 15.0,
                  width: Get.size.height * .8,
                  margin:
                      EdgeInsets.only(top: Get.size.height * .015, bottom: 0),
                  height: Get.size.height * .08,
                  loaderColor: Colors.white,
                  title: "Create a new account",
                  textColor: Colors.white,
                  itemColor: Colors.black,
                  borderColor: Colors.transparent,
                  state: validator,
                  enabled: true,
                  onTap: () async {
                    Get.toNamed(AppLinks.REGISTER);
                  }),
              Container(
                margin: EdgeInsets.only(top: Get.size.height * .008, bottom: 0),
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    'Forgot Password ?',
                    textAlign: TextAlign.justify,
                  ),
                  onPressed: () => Get.toNamed(AppLinks.FORGOT),
                ),
              )
            ],
          ),
        ),
      ),
    )));
  }

  showAlertDialog(
    BuildContext context,
    String texte2,
    String texte3,
    String texte4,
  ) {
    // set up the button

    Widget retryButton = TextButton(
      child: Text(texte2),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(texte3),
      content: Text(texte4),
      actions: [retryButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
