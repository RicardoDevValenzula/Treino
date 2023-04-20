import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:treino/notifications/provider/notification_provider.dart';

class NotificationHandler  {
  dynamic notifyCallback;
  NotificationHandler({this.notifyCallback});
  static FirebaseMessaging fcm = FirebaseMessaging.instance;
  static NotificationCubit np;
  static String token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;
  static RemoteNotification notification = message.notification;
  static  AndroidNotification android = message.notification?.android;
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications',
  importance: Importance.max,
);

  static FlutterLocalNotificationsPlugin  fltNotification;
  bool _isConfigurated = false;

  static RemoteMessage message;

  static Future _backgroundHandler(RemoteMessage message) async {
    //print( 'onBackground Handler ${ message.messageId }' );
    notification = message.notification;
    android = message.notification?.android;
    showNotification();
    _messageStream.add(message.notification?.title?? 'No tittle');
  }


  static Future _onMessageHandler(RemoteMessage message) async { 
    print( 'onMessageHandler Handler ${ message.messageId }' );
    notification = message.notification;
    android = message.notification?.android;
    showNotification();
     _messageStream.add(message.notification?.title?? 'No tittle');
  }

  
  static Future _onMessageOpenApp(RemoteMessage message) async {
    print( 'onMessageOpenApp Handler ${ message.messageId }' );
    notification = message.notification;
    android = message.notification?.android;
    showNotification();
     _messageStream.add(message.notification?.title?? 'No tittle');
  }


  static Future initializeApp() async {

    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token MotherFucker: $token');
    //handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

static closeStreams(){
  _messageStream.close();
}

  void init(NotificationCubit cubit) {
    np = cubit;
    if(!_isConfigurated){
      np.devicePlatform = Platform.isIOS ? "ios" : "android";

      if (Platform.isIOS) {        
       fcm.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: true,
          sound: true,
        );
        saveDeviceToken(np);
      } else {
        saveDeviceToken(np);
      }

      _isConfigurated = true;
    }
  }


  saveDeviceToken(NotificationCubit np) async {
    String token = await fcm.getToken();
    if (token != null) {
      np.deviceToken = token;
    }
  } 

static initMessaging(){
    var androidInit = AndroidInitializationSettings('mipmap/launcher_icon');

    var iosInit = IOSInitializationSettings();

    var initsettings = InitializationSettings(android: androidInit, iOS: iosInit);

    fltNotification=FlutterLocalNotificationsPlugin();

    fltNotification.initialize(initsettings);

  }

  static showNotification() async{
    var androidDetails = AndroidNotificationDetails(channel.id,channel.name, channelDescription: channel.description,icon: android?.smallIcon);

    var iosDetails = IOSNotificationDetails();

    var generalNotificationsDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);

    await fltNotification.show(notification.hashCode, notification.title, notification.body, generalNotificationsDetails,payload: 'Notification');
  }


 /*
  void initMessaging(){
    var androidInit = AndroidInitializationSettings('ic_launcher');

    var iosInit = IOSInitializationSettings();

    var initsettings = InitializationSettings(android: androidInit, iOS: iosInit);

    fltNotification=FlutterLocalNotificationsPlugin();

    fltNotification.initialize(initsettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      showNotification();
      print('que rollo');
    });

        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
       showNotification();
       print('que rollo');
    });

  }

  void init(NotificationCubit cubit) {
    np = cubit;
    if(!_isConfigurated){
      np.devicePlatform = Platform.isIOS ? "ios" : "android";

      if (Platform.isIOS) {        
       fcm.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: true,
          sound: true,
        );
        saveDeviceToken(np);
      } else {
        saveDeviceToken(np);
      }

      _isConfigurated = true;
    }
  }

  void showNotification() async{
    var androidDetails = AndroidNotificationDetails('channelID','channelName', channelDescription: 'Description');

    var iosDetails = IOSNotificationDetails();

    var generalNotificationsDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);

    await fltNotification.show(0, 'title', 'body', generalNotificationsDetails,payload: 'Notification');
  }

  saveDeviceToken(NotificationCubit np) async {
    String token = await fcm.getToken();
    if (token != null) {
      np.deviceToken = token;
    }
  }
*/

}
