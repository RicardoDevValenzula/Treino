import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class CoordinatesCubit extends Cubit<List<String>> {
  CoordinatesCubit() : super(null);
  // UserInfo info = new UserInfo();

  Future<bool> setCoordinates(String lat, String long) async {
    print(lat + " // " + long);
    List<String> temp = [lat, long];
    emit(temp);
  }
}
