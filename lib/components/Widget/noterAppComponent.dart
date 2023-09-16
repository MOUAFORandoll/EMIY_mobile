// // ignore: must_be_immutable
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class NoterAppComponent extends StatefulWidget {
//   NoterAppComponent();

//   @override
//   _NoterAppComponentState createState() => _NoterAppComponentState();
// }

// class _NoterAppComponentState extends State<NoterAppComponent> {
//   double _ratingStarLong = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: Get.height * .28,
//         width: Get.width * .96,
//         child: Container(
//           margin: EdgeInsets.only(top: Get.height * .02),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10), color: Colors.blue),
//           child: SingleChildScrollView(
//               child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                 Container(
//                   margin: EdgeInsets.only(top: Get.height * .01),
//                   child: Text('Attribuer une note sur 5 a notre application'),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: Get.height * .001),
//                   child: /*  RatingBar(
//                     maxRating: 5,
//                     onRatingChanged: (rating) =>
//                         setState(() => _ratingStarLong = rating),
//                     filledIcon: Icons.star,
//                     emptyIcon: Icons.star_border,
//                     halfFilledIcon: Icons.star_half,
//                     isHalfAllowed: true,
//                     filledColor: Colors.amber,
//                     size: 20,
//                   ), */
//                       RatingBar.builder(
//                     initialRating: 0.0,
//                     minRating: 0,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) =>
//                         setState(() => _ratingStarLong = rating),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: Get.height * .01),
//                   child: Text("Ajouter Un Commentaire"),
//                 ),
//                 Container(
//                     margin: EdgeInsets.only(
//                         left: Get.width * .01, top: Get.height * .01),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // CommentForm(),
//                         InkWell(
//                             child: Icon(
//                               Icons.send,
//                               size: Get.height * .09,
//                             ),
//                             onTap: () {
//                               //print('envoyer');
//                             })
//                       ],
//                     ))
//               ])),
//         ));
//   }
// }
