import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class RecuperarPasswordCubit extends Cubit<bool> {
  RecuperarPasswordCubit() : super(null);
  // UserInfo info = new UserInfo();

  Future<bool> recuperarPassword(String correo) async {
    print(correo);
    try {
      final response = await http.post(Uri.parse("https://treino.club/demo/api/AppMovil/recuperarPassword") ,
          body: jsonEncode({'correo': correo}));
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        if (responseData["error"] == 1) {
          emit(false);
          print("hay un error");
          return false;
        } else {
          emit(true);
          print("parse la info");
          return true;
        }    
    } catch (e) {
      print(e);
    }
  }
}
