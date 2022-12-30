// ignore: must_be_immutable
import 'package:fahkapmobile/styles/colorApp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoReservationComp extends StatelessWidget {
  var title, value;

  InfoReservationComp({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title :',
            ),
            Text(
              '$value',
            ),
          ],
        ));
  }
}
