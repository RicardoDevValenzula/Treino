import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/membership/membresiastate.dart';
import 'package:http/http.dart' as http;

class MembresiaCubit extends Cubit<MembresiaState> {
  MembresiaCubit() : super(InitState());
  Future<void> getMembresia(String idCliente) async{
    final response = await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getMembresiaCliente")
      ,
        body: jsonEncode({"idCliente": idCliente})
      );
    if(jsonDecode(response.body).length == 0) {
         emit(
      Success(
        "Sin membresia",
        "Sin fecha de vencimiento"
      )
      );
    return;
    }
    try{
    Map<String, dynamic> responseData = jsonDecode(response.body);
    String fechaVencimiento = responseData["fechaVencimiento"] == 
      null ? "Sin fecha de vencimiento" : responseData["fechaVencimiento"];
    print(fechaVencimiento);
    String nombre = responseData["nombre"] == null ?
     "Sin membresia" : responseData["nombre"];
    emit(
      Success(
        nombre,
        fechaVencimiento
      )
    );
    } on Exception {
    }
  }

}