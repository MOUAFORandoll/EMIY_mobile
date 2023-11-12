import 'package:EMIY/components/exportcomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:EMIY/styles/colorApp.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button(
      {this.title,
      this.itemColor,
      this.loaderColor,
      this.textColor,
      this.onTap,
      this.state,
      this.borderColor,
      this.margin,
      this.borderRadius = 5.0,
      this.height = 45,
      this.width = 300,
      this.enabled = false});
  var onTap;
  var itemColor;
  var loaderColor;
  var textColor;
  var title;
  var state;
  var borderColor;

  var borderRadius;
  var enabled;
  double height;
  double width;
  var margin;
  @override
  Widget build(BuildContext context) {
    return (state == true && state != null
        ? Container(
            height: height,
            width: width,
            constraints: const BoxConstraints(minHeight: 56),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: margin,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: borderColor == null
                  ? Border.all(color: ColorsApp.black)
                  : Border.all(color: borderColor),

              // color: (enabled)
              //     ? (itemColor == null)
              //         ? ColorsApp.skyBlue
              //         : itemColor
              //     : Colors.grey,
            ),
            child: SpinKitCircle(
              color: Colors.blue,
              size: 40,
            ),
          )
        : Container(
            height: height,
            width: width,
            margin: margin,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: borderColor == null
                  ? Border.all(color: ColorsApp.black)
                  : Border.all(color: borderColor),
              color: (enabled)
                  ? (itemColor == null)
                      ? ColorsApp.skyBlue
                      : itemColor
                  : Colors.grey,
            ),
            child: InkWell(
                onTap: onTap,
                child: Center(
                    child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ))),
          ));
  }
}

// ignore: must_be_immutable
class ButtonAction extends StatelessWidget {
  ButtonAction({
    this.title,
    this.icon,
    this.onTap,
  });
  var onTap;
  var icon;
  var title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: kMarginX / 5),
            decoration: BoxDecoration(
                color: ColorsApp.secondBlue,
                borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (title != null)
                Container(
                    child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      // fontSize:
                      //     kDescription,
                      fontFamily: 'Lato',
                      color: ColorsApp.white,
                      fontWeight: FontWeight.w700),
                )),
              if (icon != null)
                Container(
                    child: Icon(
                  icon,
                  size: 15,
                  color: ColorsApp.white,
                )),
            ])),
        onTap: onTap);
  }
}

// ignore: must_be_immutable
class ButtonIcon extends StatelessWidget {
  ButtonIcon({
    this.title,
    this.bgColor = Colors.white,
    this.textColor,
    this.onTap,
    this.icon,
  });
  var onTap;
  var bgColor;
  var loaderColor;
  var textColor;
  var title;

  var icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kWidth * .4,
      height: kHeight * .08,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: borderColor == null
        //     ? Border.all(color: ColorsApp.black)
        //     : Border.all(color: borderColor),
        color: bgColor,
      ),
      child: InkWell(
          onTap: onTap,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
              ),
              Icon(icon)
            ],
          ))),
    );
  }
}

// ignore: must_be_immutable
class Button2 extends StatelessWidget {
  Button2(
      {this.icon,
      this.itemColor,
      this.loaderColor,
      this.textColor,
      this.onTap,
      this.state,
      this.borderColor,
      this.margin,
      this.height = 0,
      this.width = 0,
      this.enabled = false});
  var onTap;
  var itemColor;
  var loaderColor;
  var textColor;
  var icon;
  var state;
  var borderColor;
  var enabled;
  double height;
  double width;
  var margin;
  @override
  Widget build(BuildContext context) {
    return (state == true && state != null
        ? Container(
            padding: EdgeInsets.only(top: 7, left: 10, right: 10, bottom: 7),
          )
        : Container(
            padding: EdgeInsets.only(right: 10, bottom: 7),
            child: InkWell(
                onTap: onTap,
                child: Center(
                    child: Icon(
                  icon,
                  color: ColorsApp.skyBlue,
                  size: 35,
                ))),
          ));
  }
}
