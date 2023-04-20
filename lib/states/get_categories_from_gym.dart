//https://treino.club/demo/api/AppMovil/getCategoriasByIdGym
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class CategoriesFromGymCubit extends Cubit<List<dynamic>> {
  CategoriesFromGymCubit() : super(null);
  dynamic response;
  void reset() => emit(null);
  void getCategoriesByID(String idGym) async {
    print('obteniendo categorias de gym ... ' + idGym);
    try {
      await http
          .post( Uri.parse("https://treino.club/demo/api/AppMovil/getCategoriasByIdGym") ,
              headers: {'Content-Type': 'application/json'},
              body: json.encode({"idGym": idGym}))
          .then((value) {
        this.response = (json.decode(value.body)['items']);
        print("point gym >>>>>");
        print(this.response);
        emit(this.response);
      });
    } catch (e) {
      print(e);
    }

    // var dio = Dio();
    // try {
    //   await dio.post("https://treino.club/demo/api/AppMovil/getClaseByID",
    //       queryParameters: {"id": id}).then((value) {
    //     print("solicitudes " + value.data);
    //     // this.items = (json.decode(value.data)['items']);
    //     emit((json.decode(value.data)));
    //   });
    // } catch (e) {
    //   // emit(null);
    //   print(e);
    // }
  }
}
