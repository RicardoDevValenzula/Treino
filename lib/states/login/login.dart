import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'loginstates.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(InitialState());
  UserInfo info = new UserInfo();
  dynamic res;

  Future<void> loginInto({String correo, String password}) async {
    print(correo);    
    print(password);
    emit(LoginCubitLoading());
    try{
       final response = await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/login")
        ,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"correo": correo, "password": password}));
        
        Map<String,dynamic> responseData = jsonDecode(response.body);
        this.res = responseData;
         if(responseData['error'] == '1'){
            emit(LoginCubitApiError(responseData['descripcion']));
            return;
          }

        emit(LoginCubitSuccess());
    } on Exception {
      emit(LoginCubitRequestError());
    }
    return Map<String,dynamic>();
  }
  void restoreState() async {
    emit(InitialState());
  }
}

class UserInfo {
  final String error;
  final String descripcion;
  final String id;
  final String nombre;
  final String apellidos;
  final String correo;
  final String creditos;
  final String telefono;
  final String ciudad;
  final String fechaNacimiento;


  UserInfo(
      {this.error,
      this.descripcion,
      this.id,
      this.nombre,
      this.apellidos,
      this.correo,
      this.creditos,
      this.telefono,
      this.ciudad,
      this.fechaNacimiento,
      });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      error: json['error'],
      descripcion: json['descripcion'],
      id: json['id'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      correo: json['correo'],
      creditos: json['creditos'],
      telefono: json['telefono'],
      ciudad: json['ciudad'],
      fechaNacimiento: json['fechaNacimiento'],
    );
  }
}
