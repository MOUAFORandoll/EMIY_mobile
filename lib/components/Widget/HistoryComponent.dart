// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:fahkapmobile/Views/ConfigView/ReservationScreen.dart';
// import 'package:fahkapmobile/model/data/VoyageModelX.dart';
// import 'package:fahkapmobile/styles/colorApp.dart';

// class HistoryComponent extends StatelessWidget {
//   final Billet reservation;

//   HistoryComponent({required this.reservation});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         child: Container(
//             margin: EdgeInsets.only(
//                 // top: Get.height * .005,
//                 left: Get.width * .03,
//                 right: Get.width * .03,
//                 bottom: Get.height * .009),
//             padding: EdgeInsets.only(
//                 // bottom: Get.height * .02,
//                 // top: Get.height * .02,
//                 // left: Get.height * .02,
//                 right: Get.height * .02),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Color(0xCA78DF80)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                     child: Row(children: <Widget>[
//                   Container(
//                     // width: Get.width,
//                     // margin: EdgeInsets.only(bottom: Get.height * .009),
//                     padding: EdgeInsets.only(
//                         bottom: Get.height * .02,
//                         top: Get.height * .02,
//                         left: Get.height * .02,
//                         right: Get.height * .02),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: ColorsApp.skyBlue),
//                     child: Icon(
//                       FontAwesomeIcons.busAlt,
//                       size: 25,
//                       color: ColorsApp.black,
//                     ),
//                   ),
//                   Container(
//                       width: Get.width * .38,
//                       margin: EdgeInsets.only(left: Get.width * .07),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             reservation.nom + ' ' + reservation.prenom,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             reservation.phone,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           // Text(reservation['date'] ?? '',
//                           //     overflow: TextOverflow.ellipsis),
//                         ],
//                       )),
//                 ])),
//                 Container(
//                     width: Get.width * .20,
//                     // margin: EdgeInsets.only(left: Get.width * .1),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           (reservation.numeroSiege).toString(),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           reservation.typeBillet,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     )),
//               ],
//             )),
//         onTap: () => Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) =>
//                 ReservationScreen(reservation: this.reservation))));
//   }
// }
