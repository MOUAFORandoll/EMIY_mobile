import 'package:flutter/material.dart';

class AppTitleRight extends StatelessWidget {
  AppTitleRight(
      {required this.title, required this.description, required this.icon});
  final String description;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Container(
              child: Text(
            title,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
          Container(child: Icon(icon))
        ],
      ),
      Container(
          child: Text(
        description,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'Montserrat',
        ),
      ))
    ]));
  }
}
