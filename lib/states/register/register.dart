import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:treino/states/register/registerstate.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialState());
  // UserInfo info = new UserInfo();

  Future<void> register(
      {String correo,
      String password,
      String nombre,
      String apellidos,
      String telefono,
      String ciudad,
      String ciudadId,
      String fechaNac,
      String genero}) async {
      emit(RegisterLoading());
      try{
        final response = await http
            .post(
              Uri.parse('https://treino.club/demo/api/AppMovil/registrar'), body: jsonEncode({
          'correo': correo,
          'password': password,
          'nombre': nombre,
          'apellidos': apellidos,
          'telefono': telefono,
          'ciudad': ciudad,
          'fechaNacimiento': fechaNac,
          'idCiudad': ciudadId,
          'genero': genero
        }));
        print(response.body);
        Map<String, dynamic> responseData = jsonDecode(response.body);
        
        if(responseData["error"] == "1"){
          emit(RegisterError("Error de registro!. ${responseData["descripcion"]}"));
          return;
        }
        
        emit(RegisterSuccess());
      } on SocketException {
        print('error');  
        emit(RegisterRequestError());
      }
  }
}
