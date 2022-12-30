// import 'package:flutter/material.dart';
// import 'package:lagacymoney/themes/color.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   static final NotificationService _notificationService =
//       NotificationService._internal();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   factory NotificationService() {
//     return _notificationService;
//   }

//   NotificationService._internal();

//   Future<void> init() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('iconlegacy');
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     tz.initializeTimeZones(); // <------

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: await selectNotification('mm'));
//   }

//   Future selectNotification(String payload) async {
//     //Handle notification tapped logic here
//   }
// }
