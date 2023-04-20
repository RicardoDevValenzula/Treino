/*  
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:treino/notifications/notification_handler.dart';

class FirebaseNotifications{
  FirebaseMessaging _messaging;
  BuildContext myContext;

  void setupFirebase(BuildContext context){
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseCloudMessageListener(context);
    myContext = context;
  }

  void firebaseCloudMessageListener(BuildContext context) async{
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );
    print('settings ${settings.authorizationStatus}');
    //Conseguimos el token
    _messaging.getToken().then((token) => print('MyToken: $token'));
    //Sub a un topic
    _messaging.subscribeToTopic("demo").whenComplete(() => print('Subscribe OK'));

    //handle Message
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      print('receive $remoteMessage');
      if(Platform.isAndroid){
       showNotification(remoteMessage.data['tittle'], remoteMessage.data['body']);
      }else if (Platform.isIOS){
       showNotification(remoteMessage.notification.title , remoteMessage.notification.body);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print('Receive open app: $remoteMessage');
      if(Platform.isIOS)
      showDialog(context: myContext, builder: (context)=>
      CupertinoAlertDialog(title: Text(remoteMessage.notification.title),
        content: Text(remoteMessage.notification.body),
        actions: [
        CupertinoDialogAction(isDefaultAction: true,
        child: Text('OK'),
        onPressed: () => Navigator.of(context,rootNavigator: true).pop(),      
        )
        ],
        ));
     });

     
  }

  static void showNotification(tittle , body) async{
    var androidChannel = AndroidNotificationDetails('com.example.treino', 'My Channel ', channelDescription: 'Description' , 
    autoCancel: false , 
    ongoing: true, 
    importance: Importance.max,
    priority: Priority.high
    );
    var ios = IOSNotificationDetails();

    var platform = NotificationDetails(
      android: androidChannel, iOS: ios);
    await NotificationHandler.flutterLocalNotificationPlugin.show(0, tittle, body, platform, payload: 'My Payload');

  }
  
}*/
