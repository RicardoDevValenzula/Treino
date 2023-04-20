import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/creditos/creditosstate.dart';
import 'package:treino/states/creditos/results.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreditosCubit extends Cubit<CreditosState> {
  CreditosCubit() : super(InitState());

  Future<void> getClases(String idCliente) async {
    List<Result> results = List<Result>();
    emit(InitState());
    print("request");
    try{
      final response = await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getCreditosGastados"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"idCliente": "$idCliente"}));
  
        Map<String,dynamic> responseData = jsonDecode(response.body);
        print(responseData);

        print(responseData["items"]["clases"]);

        if(responseData["items"]["clases"] == false){
          emit(Error());
          return;
        }

         for(int i = 0; i<responseData["items"]["clases"].length; i++){
            results.add(
              Result(
                responseData["items"]["clases"][i]["nombreClase"],
                responseData["items"]["clases"][i]["creditos"],
                responseData["items"]["clases"][i]["fecha"]
              )
            );
        }
  
        emit(Success(results, responseData["items"]["creditosTotales"], responseData["items"]["creditosGastados"]));

    } on Exception { 
      //emit(LoginCubitRequestError());
    }
    

    return null;
  }

}