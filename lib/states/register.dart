import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class RegisterCubit extends Cubit<int> {
  RegisterCubit() : super(0);
  // UserInfo info = new UserInfo();

  Future<String> register(
      {String correo,
      String password,
      String nombre,
      String apelli,
      String telefono,
      String ciudad,
      String fechaNac,
      String genero}) async {
    
      try{
        final response = await http
          .post(Uri.parse('https://treino.club/demo/api/AppMovil/registrar'), body: jsonEncode({
          'correo': correo,
          'password': password,
          'nombre': nombre,
          'apellidos': apelli,
          'telefono': telefono,
          'ciudad': ciudad,
          'fechaNacimiento': fechaNac,
          'genero': genero
        }));
        print(response.body);
        Map<String, dynamic> responseData = jsonDecode(response.body);
        
        String successStatus = responseData["error"] == "1" ? "Error de registro!. " : ''; 
        if(successStatus == '') return responseData["error"];
        return successStatus + responseData["descripcion"];
      } on SocketException {
        print('error');  
      }
      return 'Error de servidor. Intentelo mas tarde';
  }
}
