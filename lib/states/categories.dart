import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class CategoriesCubit extends Cubit<List<dynamic>> {
  CategoriesCubit() : super(null);
  // UserInfo info = new UserInfo();

  // List<dynamic> items = List();

  void getAllCategorias() async {
    var dio = Dio();
    try {
      await dio
          .get("https://treino.club/demo/api/AppMovil/getAllCategorias")
          .then((value) {
        //print(value.data);
        var itemss = (json.decode(value.data)['items']);
        emit(itemss);
        print(itemss);
      });
    } catch (e) {
      print(e);
    }
  }
}
