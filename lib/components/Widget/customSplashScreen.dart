import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        (this.loaderColor == null)
                            ? Colors.blueAccent
                            : this.loaderColor),
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
