import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/solicitarfactura/solicitarfacturastate.dart';
import './externalcontroltabstates.dart';
import './result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';

class ExternalControllerMainTabsCubit extends Cubit<dynamic> {
  ExternalControllerMainTabsCubit() : super(null);
  // TabController tabber = TabController(length: 4);

  // void animate(int val) => emit(state.animateTo(val));
}

class ExternalControllerMisClasesCubit extends Cubit<ExternalControllTabState> {
  ExternalControllerMisClasesCubit() : super(InitState());

  Future<List<Result>> getClases(String idCliente) async {
    List<Result> results = List<Result>();
    emit(RequestState("presentes"));
    try {
      final response = await http.post(
          Uri.parse('https://treino.club/demo/api/AppMovil/getSolicitudes'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "idCliente": "$idCliente",
            "hora": "${DateFormat('HH:mm:ss').format(DateTime.now())}"
          }));

      Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);

      for (int i = 0; i < responseData["items"].length; i++) {
        results.add(Result(
          responseData["items"][i]["id"],
          responseData["items"][i]["numeroControl"],
          responseData["items"][i]["creditos"],
          responseData["items"][i]["status"],
          responseData["items"][i]["horarios"][0]['hora_inicio'],
          responseData["items"][i]["horarios"][0]['hora_fin'],
          responseData["items"][i]["fecha"],
          responseData["items"][i]["nombre_gym"],
          responseData["items"][i]["nombre_clase"],
          responseData["items"][i]["onedaypass"],
        ));
      }

      emit(Success(results));
    } on Exception {
      //emit(LoginCubitRequestError());
    }
  }

  Future<List<Result>> getClasesPasadas(String idCliente) async {
    List<Result> results = List<Result>();
    emit(RequestState("pasadas"));
    try {
      final response = await http.post(
          Uri.parse(
              'https://treino.club/demo/api/AppMovil/getSolicitudesPasadas'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "idCliente": "$idCliente",
            "hora": "${DateFormat('HH:mm:ss').format(DateTime.now())}"
          }));

      Map<String, dynamic> responseData = jsonDecode(response.body);
      print(responseData);

      for (int i = 0; i < responseData["items"].length; i++) {
        results.add(Result(
          responseData["items"][i]["id"],
          responseData["items"][i]["numeroControl"],
          responseData["items"][i]["creditos"],
          responseData["items"][i]["status"],
          responseData["items"][i]["horarios"][0]['hora_inicio'],
          responseData["items"][i]["horarios"][0]['hora_fin'],
          responseData["items"][i]["fecha"],
          responseData["items"][i]["nombre_gym"],
          responseData["items"][i]["nombre_clase"],
          responseData["items"][i]["onedaypass"],
        ));
      }

      emit(Success(results));
    } on Exception {
      //emit(LoginCubitRequestError());
    }
  }

  Future<dynamic> cancelarSolicitud(String idSolicitud) async {
    dynamic djson;

    try {
      dynamic body = {"idSolicitud": idSolicitud};
      print(body);
      djson = json.decode((await http.post(
              Uri.parse(
                  "https://treino.club/demo/api/AppMovil/cancelarSolicitud"),
              body: json.encode(body)))
          .body);
      print(djson);
    } catch (e) {
      print(e);
    }
    return djson;
  }
}
