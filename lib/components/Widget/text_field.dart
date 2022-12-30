// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_utils/src/extensions/string_extensions.dart';
// import 'package:recover_money/config/style.dart';
// import 'package:recover_money/core/controller/field_manager_controller.dart';
// import 'package:recover_money/core/mixins/validator.dart';

// class KFieldType {
//   static String password = 'password';
//   static String text = 'text';
//   static String phone = 'phone';
//   static String email = 'email';
// }

// // ignore: must_be_immutable
// class KTextField extends StatelessWidget {
//   final TextEditingController controllerField;
//   final String? title;
//   final String? type;
//   final VoidCallback? onChange;
//   final List<ValidatorRule> rules;
//   final double? dim;
//   bool isCode;

//   KTextField(
//       {Key? key,
//       required this.controllerField,
//       this.title,
//       this.type,
//       this.rules = const [],
//       this.dim,
//       this.isCode = false,
//       this.onChange})
//       : super(key: key);

//   get _typekeyBord {
//     TextInputType? textType;
//     if (type == null ||
//         type == KFieldType.text ||
//         type == KFieldType.password) {
//       textType = TextInputType.text;
//     } else if (type == KFieldType.phone) {
//       textType = TextInputType.phone;
//     } else if (type == KFieldType.email) {
//       textType = TextInputType.emailAddress;
//     }
//     return textType;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: dim ?? 0),
//       child: GetBuilder<FieldManagerController>(
//           assignId: true,
//           global: false,
//           init: FieldManagerController(rules: rules),
//           builder: (controller) {
//             return Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 5),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     !isCode
//                         ? (title ?? '').capitalize!
//                         : (title ?? '').toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(.5),
//                         blurRadius: 15,
//                       ),
//                     ],
//                   ),
//                   child: Card(
//                     elevation: 2,
//                     shadowColor: Colors.black,
//                     semanticContainer: true,
//                     borderOnForeground: true,
//                     child: TextField(
//                       onChanged: (value) {
//                         onChange?.call();
//                         controller.onChange();
//                       },
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600),
//                       keyboardType: _typekeyBord,
//                       cursorRadius: const Radius.circular(20),
//                       cursorColor: const Color(0xff28255A),
//                       controller: controllerField,
//                       obscureText: type == KFieldType.password,
//                       textAlign: TextAlign.left,
//                       decoration: InputDecoration(
//                         hintText: isCode ? '1234' : '',
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                         hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 25,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ),
//                 controller.printError
//                     ? Container(
//                         alignment: Alignment.topLeft,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 8),
//                         child: Text(
//                           controller.errorMessage,
//                           style: errorStyle,
//                         ))
//                     : Container(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
