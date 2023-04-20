import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:rabbit_converter/rabbit_converter.dart';
// import 'package:unorm_dart/unorm_dart.dart';
import "package:unorm_dart/unorm_dart.dart" as unorm;

class GymsPerCategoryCubit extends Cubit<List<dynamic>> {
  GymsPerCategoryCubit() : super(null);
  // UserInfo info = new UserInfo();
  List<dynamic> items = List();
  String idCategoriaSeleccionado = "1";

  void setIdCategoria(String val) {
    this.idCategoriaSeleccionado = val;
  }

  void reset() {
    emit(null);
  }

  void getGymByCategoria(String idCategorie) async {
    final response = await http.post( Uri.parse('https://treino.club/demo/api/AppMovil/getGymsByCategoria')
       ,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: json.encode({"idCategoria": idCategorie}));
    // String body = utf8.decode(response.bodyBytes);
    // String source = Utf8Decoder().convert(response.bodyBytes);
    var myRichRunesMessage = new Runes(response.body);
    // String source = String.fromCharCodes(myRichRunesMessage);
    print(response.body);
    this.items = json.decode(response.body)['items'];
    // String temp = Rabbit.zg2uni(json.encode(this.items));

    print("============");
    print(this.items);
    // print(json.encode(this.items));
    // print(temp);
    // print(String.fromCharCodes(response.bodyBytes));
    print("============");

    // var combining = RegExp(r"[\u0300-\u036F]/g");
    // String text = temp;
    // print("Regular:  ${response.body.runes.toString()}");
    // print("NFC:      ${unorm.nfc(text)}");
    // print("NFKC:     ${unorm.nfkc(text)}");
    // print("NFKD: *   ${unorm.nfkd(response.body)}");
    // print(" * = Combining characters removed from decomposed form.");

    emit(this.items);
  }
}
