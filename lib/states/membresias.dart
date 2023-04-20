import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MembresiasCubit extends Cubit<List<dynamic>> {
  MembresiasCubit() : super(null);
  List<dynamic> items;
  void getMembresias() async {
    var dio = Dio();
    try {
      await dio
          .get("https://treino.club/demo/api/AppMovil/getMembresias")
          .then((value) {
        this.items = (json.decode(value.data)['items']);
        print("membresias .... ");
        print(this.items);
        emit(this.items);
      });
    } catch (e) {
      print(e);
    }
  }
}
