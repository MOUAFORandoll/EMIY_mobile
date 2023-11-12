import 'package:EMIY/components/Widget/CircleImage.dart';
import 'package:EMIY/components/exportcomponent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/model/data/UserTagModel.dart';

// ignore: must_be_immutable
class UserTagComponent extends StatelessWidget {
  UserTagComponent({required UserTagModel this.user, this.onTap});
  final user, onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: kMarginY, horizontal: kMarginX),
          // decoration: BoxDecoration(
          //   color: ColorsApp.grey,
          // ),
          child: Row(
            children: [
              Container(
                  child: CircleImage(
                imageUrl: this.user.profile,
              )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: kMarginX),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(this.user.nom,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 13,
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.w500,
                            color: ColorsApp.black,
                          )),
                      Text(this.user.user_tag),
                    ]),
              ),
              // Icon(Icons.arrow_forward_ios_sharp)
            ],
          ),
        ));
  }
}
