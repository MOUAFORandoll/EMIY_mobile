import 'package:fahkapmobile/components/Button/button.dart';
import 'package:fahkapmobile/components/Button/customBtn.dart';
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:get/get.dart';

class ForgotPassordScreen extends StatefulWidget {
  const ForgotPassordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassordScreenState createState() => _ForgotPassordScreenState();
}

class _ForgotPassordScreenState extends State<ForgotPassordScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  bool error = false;
  bool is_disable = false;
  late int telephone;
  late String password;
  // AuthProvider api = AuthProvider();
  // GetStorage box = GetStorage();

  bool validator = false;
  bool validator2 = false;

  bool enabled = false;
  bool enableD = true;
  bool loading = false;
  /* 
  bool enableName = true;
  bool enableMail = true;
  bool enablePasword = true;
  bool enableNumber = true; */
  var phoneSa = '';
  var nom = '';
  var mailSa = '';

  var passSa = '';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // api.onInit();
  }

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

  bool enabledData = false;
  String payCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                //child:padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(Icons.home),
                              onPressed: () {
                                Get.toNamed(AppLinks.HOME);
                              })
                        ]),
                    Text(
                      "Forgot Pasword ?",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Enter your Email address or Number",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              mailSa,
                              style: TextStyle(
                                fontFamily: 'orkney',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ]),
                    ),
                    TextFormField(
                      enabled: enableD,
                      controller: email,
                      onSaved: (value) {},
                      validator: (value) {
                        return value == "" ? "veuillez remplir ce champ" : null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            // width: 10
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 15,
                          right: 15,
                        ),
                        hintText: "Email or Number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          if (!val.contains(RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"))) {
                            setState(() {
                              mailSa = "mauvaise adresse mail";
                            });
                          } else {
                            setState(() {
                              mailSa = "correct mail address";
                            });
                          }
                          if (val.isEmpty) {
                            setState(() {
                              mailSa = "";
                            });
                          }
                        }
                        if ((name.text.isNotEmpty &&
                            surname.text.isNotEmpty &&
                            email.text.contains(RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) &&
                            phone.text.isNotEmpty &&
                            pass.text.isNotEmpty &&
                            (RegExp(r'^(0|[1-9]\d*)$').hasMatch(phone.text) &&
                                phone.text.length == 9))) {
                          setState(() {
                            enabled = true;
                          });
                          print("access");
                        } else {
                          setState(() {
                            enabled = false;
                          });
                          print("eroorrrrrrrrr");
                        }
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Button(
                          height: 45,
                          title: "Next",
                          textColor: Colors.white,
                          itemColor: ColorsApp.skyBlue,
                          loaderColor: Colors.white,
                          enabled: enabled,
                          state: validator,
                          onTap: () async {
                            print("deb");
                            _tabController.index++;
                            // if (phone.text.isEmpty ||
                            //     pass.text.isEmpty ||
                            //     name.text.isEmpty) {
                            //   Toast.show(
                            //     "Veillez remplir tout les champs",
                            //     context,
                            //     duration: 6,
                            //     gravity: Toast.BOTTOM,
                            //     backgroundColor: Colors.red,
                            //   );
                            //   return 0;
                            // } else if (phone.text.length > 8 &&
                            //     pass.text.length == 5 &&
                            //     name.text.length >= 3 &&
                            //     (RegExp(r'^(0|[1-9]\d*)$')
                            //             .hasMatch(phone.text) &&
                            //         phone.text.length == 9) &&
                            //     (email.text.contains(RegExp(
                            //         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")))) {
                            //   setState(() {
                            //     enableD = false;
                            //     validator = !validator;
                            //   });
                            //   var data = <String, dynamic>{
                            //     "email": email.text.toLowerCase(),
                            //     /*    "roles": ["ROLE_MEMBRE"], */
                            //     "password": pass.text,
                            //     "nom": name.text,
                            //     "prenom": "Prenom",
                            //     "phone": phone.text,
                            //     "codePhone": payCode,
                            //     "adress": "",
                            //     "ville": "",
                            //     "quartier": "",
                            //     "numCni": "",
                            //     "nameRep": "",
                            //     "prenomRep": "",
                            //     /*   "status": true, */
                            //     "typemembre": "/api/type_membres/1",
                            //     "pays": "",
                            //     "latitude": 0,
                            //     "longitude": 0
                            //   };
                            //   print(
                            //       "Incription en cours********************* $data");
                            // } else {
                            //   if (name.text.length < 4) {
                            //     Toast.show(
                            //       "Le nom doit avoir au moins 3 caracteres",
                            //       context,
                            //       duration: 6,
                            //       gravity: Toast.BOTTOM,
                            //       backgroundColor: Colors.red,
                            //     );
                            //   }

                            //   if (phone.text.length < 9) {
                            //     Toast.show(
                            //       "Veillez entrer un numero correct",
                            //       context,
                            //       duration: 6,
                            //       gravity: Toast.BOTTOM,
                            //       backgroundColor: Colors.red,
                            //     );
                            //   }
                            //   if (pass.text.length < 5) {
                            //     Toast.show(
                            //       "Le mot de passe doit avoir au moins 5 caracteres",
                            //       context,
                            //       duration: 6,
                            //       gravity: Toast.BOTTOM,
                            //       backgroundColor: Colors.red,
                            //     );
                            //   }

                            //   if (!(email.text.contains(RegExp(
                            //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")))) {
                            //     Toast.show(
                            //       "Entrer une adresse mail correct",
                            //       context,
                            //       duration: 6,
                            //       gravity: Toast.BOTTOM,
                            //       backgroundColor: Colors.red,
                            //     );
                            //   }
                            // }
                          }),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                //child:padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon(Icons.home), onPressed: () {})
                        ]),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        //child:padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          'Remplissez les champs suivants pour recuperer votre compte',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                          ),
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Code de validation",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*  Text(
                            mailSa,
                            style: TextStyle(
                              fontFamily: 'orkney',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ) */
                        ]),
                    TextFormField(
                      enabled: enableD,
                      controller: email,
                      onSaved: (value) {},
                      validator: (value) {
                        return value == "" ? "veuillez remplir ce champ" : null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            // width: 10
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 15,
                          right: 15,
                        ),
                        hintText: "Code de validation",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          if (!val.contains(RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"))) {
                            setState(() {
                              mailSa = "mauvaise adresse mail";
                            });
                          } else {
                            setState(() {
                              mailSa = "correct mail address";
                            });
                          }
                          if (val.isEmpty) {
                            setState(() {
                              mailSa = "";
                            });
                          }
                        }
                        if ((name.text.isNotEmpty &&
                            surname.text.isNotEmpty &&
                            email.text.contains(RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) &&
                            phone.text.isNotEmpty &&
                            pass.text.isNotEmpty &&
                            (RegExp(r'^(0|[1-9]\d*)$').hasMatch(phone.text) &&
                                phone.text.length == 9))) {
                          setState(() {
                            enabled = true;
                          });
                          print("access");
                        } else {
                          setState(() {
                            enabled = false;
                          });
                          print("eroorrrrrrrrr");
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mot de passe",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            passSa,
                            style: TextStyle(
                              fontFamily: 'orkney',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                    TextFormField(
                      enabled: enableD,
                      onChanged: (value) {
                        error = true;

                        if (value.length < 5) {
                          setState(() {
                            passSa = "Minimun 5 caracteres";
                          });
                        } else {
                          setState(() {
                            passSa = "";
                          });
                        }

                        setState(() {
                          password = value;
                        });

                        if (phone.text.isNotEmpty && value.isNotEmpty) {
                          setState(() {
                            enabledData = true;
                          });
                          print("Activate ber *********");
                        } else {
                          setState(() {
                            enabledData = false;
                          });
                          print("DesaActivate ber *********");
                        }
                        if ((name.text.isNotEmpty &&
                            surname.text.isNotEmpty &&
                            email.text.contains(RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) &&
                            phone.text.isNotEmpty &&
                            pass.text.isNotEmpty &&
                            (RegExp(r'^(0|[1-9]\d*)$').hasMatch(phone.text) &&
                                phone.text.length == 9))) {
                          setState(() {
                            enabled = true;
                          });
                          print("access");
                        } else {
                          setState(() {
                            enabled = false;
                          });
                          print("eroorrrrrrrrr");
                        }
                      },
                      onFieldSubmitted: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      controller: pass,
                      validator: (value) {
                        return value!.isEmpty ? "enter your password" : null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      obscuringCharacter: "*",
                      maxLength: 5,
                      decoration: new InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            // width: 10
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 15,
                          right: 15,
                        ),
                        hintText: ". . . . . ",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        // errorText: error ? "this field is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "repeter Mot de passe",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            passSa,
                            style: TextStyle(
                              fontFamily: 'orkney',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                    TextFormField(
                      enabled: enableD,
                      onChanged: (value) {
                        error = true;

                        if (value.length < 5) {
                          setState(() {
                            passSa = "Minimun 5 caracteres";
                          });
                        } else {
                          setState(() {
                            passSa = "";
                          });
                        }

                        setState(() {
                          password = value;
                        });

                        if (phone.text.isNotEmpty && value.isNotEmpty) {
                          setState(() {
                            enabledData = true;
                          });
                          print("Activate ber *********");
                        } else {
                          setState(() {
                            enabledData = false;
                          });
                          print("DesaActivate ber *********");
                        }
                        if ((name.text.isNotEmpty &&
                            surname.text.isNotEmpty &&
                            email.text.contains(RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")) &&
                            phone.text.isNotEmpty &&
                            pass.text.isNotEmpty &&
                            (RegExp(r'^(0|[1-9]\d*)$').hasMatch(phone.text) &&
                                phone.text.length == 9))) {
                          setState(() {
                            enabled = true;
                          });
                          print("access");
                        } else {
                          setState(() {
                            enabled = false;
                          });
                          print("eroorrrrrrrrr");
                        }
                      },
                      onFieldSubmitted: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      controller: pass,
                      validator: (value) {
                        return value!.isEmpty ? "enter your password" : null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      obscuringCharacter: "*",
                      maxLength: 5,
                      decoration: new InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            // width: 10
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 15,
                          right: 15,
                        ),
                        hintText: ". . . . . ",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        // errorText: error ? "this field is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Button(
                        height: 45,
                        title: "ForgotPassord",
                        width: Get.size.width,
                        textColor: Colors.white,
                        itemColor: ColorsApp.skyBlue,
                        loaderColor: Colors.white,
                        enabled: enabled,
                        state: validator,
                        onTap: () async {
                          print("deb");

                          // if (phone.text.isEmpty ||
                          //     pass.text.isEmpty ||
                          //     name.text.isEmpty) {
                          //   Toast.show(
                          //     "Veillez remplir tout les champs",
                          //     context,
                          //     duration: 6,
                          //     gravity: Toast.BOTTOM,
                          //     backgroundColor: Colors.red,
                          //   );
                          //   return 0;
                          // } else if (phone.text.length > 8 &&
                          //     pass.text.length == 5 &&
                          //     name.text.length >= 3 &&
                          //     (RegExp(r'^(0|[1-9]\d*)$')
                          //             .hasMatch(phone.text) &&
                          //         phone.text.length == 9) &&
                          //     (email.text.contains(RegExp(
                          //         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")))) {
                          //   setState(() {
                          //     enableD = false;
                          //     validator = !validator;
                          //   });
                          //   var data = <String, dynamic>{
                          //     "email": email.text.toLowerCase(),
                          //     /*    "roles": ["ROLE_MEMBRE"], */
                          //     "password": pass.text,
                          //     "nom": name.text,
                          //     "prenom": "Prenom",
                          //     "phone": phone.text,
                          //     "codePhone": payCode,
                          //     "adress": "",
                          //     "ville": "",
                          //     "quartier": "",
                          //     "numCni": "",
                          //     "nameRep": "",
                          //     "prenomRep": "",
                          //     /*   "status": true, */
                          //     "typemembre": "/api/type_membres/1",
                          //     "pays": "",
                          //     "latitude": 0,
                          //     "longitude": 0
                          //   };
                          //   print(
                          //       "Incription en cours********************* $data");
                          // } else {
                          //   if (name.text.length < 4) {
                          //     Toast.show(
                          //       "Le nom doit avoir au moins 3 caracteres",
                          //       context,
                          //       duration: 6,
                          //       gravity: Toast.BOTTOM,
                          //       backgroundColor: Colors.red,
                          //     );
                          //   }

                          //   if (phone.text.length < 9) {
                          //     Toast.show(
                          //       "Veillez entrer un numero correct",
                          //       context,
                          //       duration: 6,
                          //       gravity: Toast.BOTTOM,
                          //       backgroundColor: Colors.red,
                          //     );
                          //   }
                          //   if (pass.text.length < 5) {
                          //     Toast.show(
                          //       "Le mot de passe doit avoir au moins 5 caracteres",
                          //       context,
                          //       duration: 6,
                          //       gravity: Toast.BOTTOM,
                          //       backgroundColor: Colors.red,
                          //     );
                          //   }

                          //   if (!(email.text.contains(RegExp(
                          //       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")))) {
                          //     Toast.show(
                          //       "Entrer une adresse mail correct",
                          //       context,
                          //       duration: 6,
                          //       gravity: Toast.BOTTOM,
                          //       backgroundColor: Colors.red,
                          //     );
                          //   }
                          // }
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                            height: 40,
                            width: Get.size.width * .4,
                            // margin: EdgeInsets.only(left: 40, right: 40),
                            title: "Back",
                            itemColor: Colors.transparent,
                            loaderColor: ColorsApp.skyBlue,
                            textColor: ColorsApp.skyBlue,
                            state: false,
                            enabled: true,
                            onTap: () {
                              _tabController.index--;
                            },
                          ),
                          Button(
                            height: 40, width: Get.size.width * .4,
                            // margin: EdgeInsets.only(left: 40, right: 40),
                            title: "Se Connecter",
                            itemColor: Colors.transparent,
                            loaderColor: ColorsApp.skyBlue,
                            textColor: ColorsApp.skyBlue,
                            state: false,
                            enabled: true,
                            onTap: () async {
                              // Navigator.of(context)
                              //     .pushReplacement(MaterialPageRoute(
                              //         builder: (context) => LogPhone()))
                              //     .then((value) {
                              //   if (mounted) {
                              //     setState(() {
                              //       validator2 = false;
                              //     });
                              //   }
                              // });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
