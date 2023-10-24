import 'package:flutter/material.dart';
import 'package:EMIY/styles/colorApp.dart';

class InfoComponent extends StatelessWidget {
  InfoComponent({this.title, this.value, this.divider, this.onTap});

  var title, value, divider, onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 3),
        margin: EdgeInsets.only(bottom: 3),
        decoration: ((divider == null) ? true : divider)
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
              )
            : BoxDecoration(),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            Text(value,
                style: TextStyle(
                    fontSize: 15,
                    color: ColorsApp.black,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
