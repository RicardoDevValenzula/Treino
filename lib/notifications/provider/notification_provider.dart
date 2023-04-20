import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/notifications/notification_handler.dart';
import 'package:http/http.dart' as http;

class NotificationCubit extends Cubit<dynamic> {

  dynamic _notification = {};
  List _notificationPool = [];
  String _deviceToken;
  String _devicePlatform;
  NotificationHandler _notificationHandler = new NotificationHandler();

  BuildContext _context;

  NotificationCubit() : super(0);

  get notification => _notification;
  get notificationPool => _notificationPool;
  get deviceToken => _deviceToken;
  get devicePlatform => _devicePlatform;

  get appContext => _context;

  get notificationHandler => _notificationHandler;

  set deviceToken( String token ) {
    _deviceToken = token;
  }

  set appContext( BuildContext context ) {
    _context = context;
  }

  set devicePlatform( String platform ) {
    _devicePlatform = platform;    
  }

  Future<bool> updateDeviceToken({String userId}) async {    
    bool success = false;
    try {
      dynamic body = {
        "idCliente": userId,
        "tokenFirebase": this.deviceToken
      };
      print(body);
      dynamic djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/agregarTokenFirebase") , body: json.encode(body))).body);
      print(djson);
      success = djson['error'] == "0";
    } catch (e) {
      print(e);
    }
    return success;
  }

}
