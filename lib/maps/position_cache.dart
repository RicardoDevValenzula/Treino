import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treino/notifications/notification_handler.dart';
import 'package:http/http.dart' as http;

class PositionCache extends Cubit<dynamic> {  

  LatLng _lastPos = LatLng(0, 0);
  double _camZoom = 14;

  PositionCache() : super(0);

  get lastPos => _lastPos;
  get camZoom => _camZoom;    

  set lastPos( LatLng newPos ) {
    _lastPos = newPos;
  }

  set camZoom( double newZoom ) {
    _camZoom = newZoom;
  }

  CameraUpdate getCameraUpdate() => CameraUpdate.newLatLngZoom(this._lastPos, this._camZoom);
}
