import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class GymDetailCubit extends Cubit<int> {
  GymDetailCubit() : super(null);
  var response;
  void getGymById(String id) async {
    var dio = Dio();
    // try {
    //   await dio.get("https://treino.club/demo/api/AppMovil/getGymByID",
    //       queryParameters: {"id": id}).then((value) {
    //     print(value.data);
    //     this.response = (json.decode(value.data));
    //   });
    // } catch (e) {
    //   print(e);
    // }
    final response = await http.post( Uri.parse('https://treino.club/demo/api/AppMovil/getGymByID')
        ,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"id": id}));
    print(jsonDecode(response.body));
    emit(jsonDecode(response.body));
  }
}
