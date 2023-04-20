import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ComprarMembresiasCubit extends Cubit<int> {
  ComprarMembresiasCubit() : super(0);
  var response;
  String idMembresiaSelected= "-";
  String idCliente = "-";

  void setIdCliente(String id) async {
    this.idCliente = id;
    print("recibido : " + idCliente);
  }

  void setIdMembresia(String id) async {
    this.idMembresiaSelected = id;
    print("recibido : " + idMembresiaSelected);
  }

  void comprarMembresia(String idCli, String idMembre) async {
    print("parametros de compra > " +
        "cliente " +
        this.idCliente +
        " || " +
        "id membresia " +
        this.idMembresiaSelected);
    var dio = Dio();
    try {
      await dio.post("https://treino.club/demo/api/AppMovil/comprarMembresia",
          data: {
            "idMembresia": this.idMembresiaSelected,
            "idCliente": this.idCliente
          }).then((value) {
        print(value.data);
        this.response = (json.decode(value.data));
        if (this.response['error'] == "0") {
          print("compra de membresia exitosa");
        } else {
          print("error al comprar membresia");
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
