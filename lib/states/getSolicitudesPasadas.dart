import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class SolicitudesPasadasCubit extends Cubit<List<dynamic>> {
  SolicitudesPasadasCubit() : super(null);
  List<dynamic> items;
  void getSolicitudesPasadas(String idCliente) async {
    var dio = Dio();
    try {
      await dio.get(
          "https://treino.club/demo/api/AppMovil/getSolicitudesPasadas",
          queryParameters: {
            "idCliente": idCliente,
          }).then((value) {
        print("solicitudes pasadas " + value.data);
        this.items = (json.decode(value.data)['items']);
        print(this.items);
        emit(this.items);
      });
    } catch (e) {
      print(e);
    }
  }
}
