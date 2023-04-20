import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SolicitudesCubit extends Cubit<List<dynamic>> {
  SolicitudesCubit() : super(null);
  List<dynamic> items;
  void getSolicitudes(String idCliente) async {
    var dio = Dio();
    try {
      await dio.get("https://treino.club/demo/api/AppMovil/getSolicitudes",
          queryParameters: {
            "idCliente": idCliente,
          }).then((value) {
        print("solicitudes " + value.data);
        this.items = (json.decode(value.data)['items']);
        emit(this.items);
      });
    } catch (e) {
      print(e);
    }
  }
}
