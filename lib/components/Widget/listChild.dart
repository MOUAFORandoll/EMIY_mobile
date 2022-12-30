// ignore: must_be_immutable
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListWidget extends StatelessWidget {
  var title, subtitle, icon, onTap;

  ListWidget({this.icon, this.title, this.onTap, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: ColorsApp.skyBlue,
          radius: 25,
          child: Icon(icon, size: 15, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: 'orkney', fontSize: 15),
        ),
        subtitle: Container(
            child: Text(subtitle, style: TextStyle(fontFamily: 'orkney')),
            margin: EdgeInsets.only(top: 3, bottom: 3)),
      ),
    );
  }
}
