import 'dart:async'; 

import 'package:EMIY/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart'; 
import '../../model/socket/NotificationModel.dart';
import 'routing.dart';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher_icon');
    final StreamController<ReceivedNotification>
        didReceiveLocalNotificationStream =
        StreamController<ReceivedNotification>.broadcast();
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestSoundPermission: true,
    //         requestBadgePermission: true,
    //         requestAlertPermission: true,
    //         onDidReceiveLocalNotification:
    //             (int? id, String? title, String? body, String? payload) async {
    //           print('............');
    //         });
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) async {
              didReceiveLocalNotificationStream.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;

      print('p----------------------ayload');
      if (payload != null) {
        // Gérer l'action selon la valeur du payload
        if (payload == 'Service_Client') {
          Get.toNamed(AppLinks.SERVICE_CLIENT);
        } else if (payload == 'Negociation') {
          Get.toNamed(AppLinks.NEGOCIATION_LIST);
        }
      }
    });
  }

  Future<void> emitNotification(content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'emiy_general_1', // Channel ID
      'emiy Negociation', // Channel name
      channelDescription: 'Information Negociation', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      // autoCancel: false,
      // setAsGroupSummary: true,
      styleInformation: BigTextStyleInformation(
        '<Notification Content>', // Replace with your custom notification content
        htmlFormatBigText: true,
        contentTitle:
            'Negociation', // Replace with your custom notification title
        summaryText:
            'Negociation', // Replace with your custom notification summary
      ),
      icon: 'launcher_icon',
      largeIcon: DrawableResourceAndroidBitmap(
          'launcher_icon'), // Replace with the name of your custom large icon file
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID (should be unique for each notification)
      'Negociation', // Notification title
      content, // Notification body
      platformChannelSpecifics,
      payload: 'Negociation',
    );
  }

  Future<void> emitServiceClient(content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'emiy_general_1', // Channel ID
      'emiy Service client', // Channel name
      channelDescription: 'Information Service client', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      // autoCancel: false,
      // setAsGroupSummary: true,
      styleInformation: BigTextStyleInformation(
        '<Notification Content>', // Replace with your custom notification content
        htmlFormatBigText: true,
        contentTitle:
            'Service client', // Replace with your custom notification title
        summaryText:
            'Service client', // Replace with your custom notification summary
      ),
      icon: 'launcher_icon',
      largeIcon: DrawableResourceAndroidBitmap(
          'launcher_icon'), // Replace with the name of your custom large icon file
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID (should be unique for each notification)
      'Service_Client', // Notification title
      content, // Notification body
      platformChannelSpecifics,
      payload: 'Service_Client',
    );
  }

  Future<void> emitNotificationGenearal(content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'emiy_general_1', // Channel ID
      'emiy general', // Channel name
      channelDescription: 'Information general', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: false,
      // setAsGroupSummary: true,
      styleInformation: BigTextStyleInformation(
        '<Notification Content>', // Replace with your custom notification content
        htmlFormatBigText: true,
        contentTitle: 'General', // Replace with your custom notification title
        summaryText:
            'Information General', // Replace with your custom notification summary
      ),
      icon: 'launcher_icon',
      largeIcon: DrawableResourceAndroidBitmap(
          'launcher_icon'), // Replace with the name of your custom large icon file
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID (should be unique for each notification)
      'General', // Notification title
      content, // Notification body
      platformChannelSpecifics,
      payload: 'action1',
    );
  }

  Future<void> emitNotifications(NotificationModel content) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'emiy_general_1', // Channel ID
      'emiy general', // Channel name
      channelDescription: 'Notifications', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: false,
      // setAsGroupSummary: true,
      styleInformation: BigTextStyleInformation(
        '<Notification Content>', // Replace with your custom notification content
        htmlFormatBigText: true,
        // Replace with your custom notification title
        summaryText:
            'Notifications', // Replace with your custom notification summary
      ),
      icon: 'launcher_icon',
      largeIcon: DrawableResourceAndroidBitmap(
          'launcher_icon'), // Replace with the name of your custom large icon file
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID (should be unique for each notification)
      content.title, // Notification title
      content.description, // Notification body
      platformChannelSpecifics,
      payload: 'action1',
    );
  }
}
