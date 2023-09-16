import 'package:EMIY/controller/MySearchController.dart';
import 'package:EMIY/styles/colorApp.dart';
import 'package:EMIY/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

// ignore: must_be_immutable
class KSearchField extends StatelessWidget {
  final String? title;
  Function? onChange;
  final double? dim;
  bool isCode;

  KSearchField(
      {Key? key, this.title, this.dim, this.isCode = false, this.onChange})
      : super(key: key);
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MySearchController>(builder: (searchCont) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorsApp.greySecond,
        ),

        height: kToolbarHeight / 1.7,
        width: kWidth * .75,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onChanged: (String value) {
            // if (onChange != null) onChange!(value);
            searchCont.clearSearch();
          },
          focusNode: _focusNode,
          // cursorHeight: 30.0,
          controller: searchCont.controllerField,
          // textAlign: TextAlign.left,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5),
            prefixIcon: Icon(Icons.search),
            suffixIcon: searchCont.tsearch == 0
                ? null
                : InkWell(
                    onTap: () {
                      searchCont.clearAll();
                    },
                    child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(15),
                        //   color: ColorsApp.greySearch,
                        // ),
                        child: Icon(Icons.close))),
            // prefixIcon: InkWell(
            //     onTap: () {
            //       searchCont.selectFilter();
            //     },
            //     child: Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           color: ColorsApp.greySearch,
            //         ),
            //         // height: searchCont.tsearch == 0 ? 0 : kToolbarHeight / 1.9,
            //         width: kMdWidth * 0.7,
            //         // margin: EdgeInsets.only(
            //         //   left: 3,
            //         // ).add(
            //         //   EdgeInsets.symmetric(vertical: 0),
            //         // ),

            //         padding: EdgeInsets.symmetric(
            //           horizontal: 5,
            //         ),
            //         child: Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(child: Icon(Icons.settings)),
            //     Container(
            //         margin: EdgeInsets.only(left: 5),
            //         child: searchCont.tsearch == 0
            //             ? Text(
            //                 'produit',
            //                 style: TextStyle(
            //                     color: ColorsApp.secondBlue,
            //                     fontSize: 14),
            //               )
            //             : searchCont.tsearch == 1
            //                 ? Text(
            //                     'boutique',
            //                     style: TextStyle(
            //                         color: ColorsApp.secondBlue,
            //                         fontSize: 14),
            //                   )
            //                 : Text(
            //                     'categorie',
            //                     style: TextStyle(
            //                         color: ColorsApp.secondBlue,
            //                         fontSize: 14),
            //                   ))
            //   ],
            // ))),

            hintText: isCode ? '1234' : 'Recherche',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.zero,
            ),
            prefixStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            // contentPadding: EdgeInsets.symmetric(vertical: 10),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
}
