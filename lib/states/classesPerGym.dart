import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ClassesPerGymCubit extends Cubit<List<dynamic>> {
  ClassesPerGymCubit() : super(null);
  // UserInfo info = new UserInfo();
  List<dynamic> items = List();
  String idCategoriaSeleccionado = "1";

  void setIdCategoria(String val) {
    this.idCategoriaSeleccionado = val;
  }

  void reset() => emit(null);

  void getClassesByGym(String idGym) async {
    final response = await http.post
    (Uri.parse('https://treino.club/demo/api/AppMovil/getListaClasesByGimnasio'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"idGym": idGym}));
    // print(jsonDecode(response.body)['items']);
    // print(jsonDecode(response.body)['items']);
    // print("mergas >>> " + response.body);
    // print("mergas >>> " + response.body);
    try {
      print("parseando //// ");
      print(jsonDecode(response.body)['items']);
      this.items = jsonDecode(response.body)['items'];
    } catch (e) {
      print("error json");
    }

    emit(this.items);
  }
}
