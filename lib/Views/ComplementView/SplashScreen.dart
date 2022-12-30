import 'package:get/get.dart';
import 'package:fahkapmobile/utils/DataBase/DataBase.dart';
import 'package:fahkapmobile/utils/Services/routing.dart';
import 'package:fahkapmobile/utils/api/apiUrl.dart';
import 'package:fahkapmobile/utils/functions/route.dart';
import 'package:fahkapmobile/utils/provider/refresh_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:fahkapmobile/views/UsersMange/LoginScreen.dart';
import 'package:fahkapmobile/views/ComplementView/wrapper.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  // GetStorage box = GetStorage();
  // int isOpen = 0;
  // var rep = 0;
  // int count = 0;
  // var data;
  start() {
    Future.delayed(Duration(seconds: 3), () async {
      print('10');
      Get.offAndToNamed(AppLinks.FIRST);
    });
  }

  // late Animation<double> _progress;
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   _animationController.dispose();

  //   super.dispose();
  // }

  // late Color color = Colors.red.shade900;

  // bool _isLoading = false;

  @override
  void initState() {
    start();
  }

  late double height = 0;
  late String texte = "";

  bool _isOpened = false;
  late AnimationController _animationController;

  bool tile = false;

  @override
  void animate() {
    if (_isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _isOpened = !_isOpened;
    });
  }

  ///@newConnexion start the new post in table connexion for userApp
  // getuser() async {
  //   var date =
  //       "${new DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())}";

  //   try {
  //     var token;
  //     print("loddddddddddddddddddddddddddddddd");
  //     await CustomDio().refreshToken();
  //     print("***************-ddddddddddddddddddddd");

  //     var dio = await CustomDio().getApiClient();

  //     print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");

  //     try {
  //       print("Wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
  //       final response = await dio.get(
  //         "/api/publications",
  //       );
  //       print("reppppppp ${response.data}");
  //       if (response.statusCode == 201 || response.statusCode == 200) {
  //         print("nouvelle connexion ok");
  //         setState(() {
  //           rep = 1;
  //         });
  //       } else {
  //         print("errorrrrrr nouvelle connexion ok ${response.statusCode}");
  //       }
  //     } catch (e) {
  //       setState(() {
  //         rep = 2;
  //       });
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return /* (isOpen == 0)
        ? */
        NewSplashScreen(
            title: "Fah Kap",
            //  subtitle: "LEGACY FINANCE \n Digital Finance",
            image: 'assets/logo.png',
            /*  loaderColor: Colors.yellow, */
            size: 70.0);
    // : (isOpen == 1)
    //     ? Wrapper()
    //     : LoginScreen();
  }
}

class NewSplashScreen extends StatelessWidget {
  NewSplashScreen(
      {this.title, this.subtitle, this.image, this.loaderColor, this.size});
  var title, subtitle, image, loaderColor, size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              flex: 2,
              child: new Container(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    radius: double.parse(this.size.toString()),
                    backgroundColor: Colors.transparent,
                    child: Hero(
                      tag: "splashscreenImage",
                      child: new Container(child: Image.asset(this.image)),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                  ),
                  Text(this.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitCircle(
                    color: Colors.blue,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  (this.subtitle == null) ? Text('') : Text(this.subtitle)
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
