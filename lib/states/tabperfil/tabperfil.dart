import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';


class TabPerfilCubit extends Cubit<int> {
  TabPerfilCubit(int state) : super(state);

  Future<bool> sendPerfilPhoto (String userId, File path) async { 
    final dio = Dio();
    
    List<int> imageBytes = path.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    
    FormData formData = new FormData.fromMap({
      "id": userId,
      "fotoPerfil": baseimage
    });

    final response = await dio.post("https://treino.club/demo/api/AppMovil/actualizarFotoProfile", data: formData);
    print(response);
  }

}