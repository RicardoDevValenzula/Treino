import 'dart:convert';
//Estara comentada hasta que se sepa como usar.
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeWrapper {
  
  StripeWrapper({prod}){
      //Tokens Nuevos.
     // String testPK = "pk_test_51JZPulHnxLVe9F23Ao6XiquKJQOtWiZwxX7MDZry7jw93VPpZIQpx7MlzjlJBpgEDSlF1vkvq0Ka8xTd2e75JGR600z5249kKg";
     // String prodPK = "pk_live_51JZPulHnxLVe9F23mQbBdd7EL47l6IIYo4ZlXH891EmjqnKz32ZBTQRrTolDkx9UPspMLzsFEN0IafHUgPADcLvM00yrRmbLnO";
      //Tokens Antiguas 
    String testPK = "pk_test_51HHa1ZDMvatWijjUr4R4KGpw5HNa0PhCr1houTTdRnZn3A68kJk05Y0SsgdbrP0yGXi86FaFbLug7ah9B4ElFVf000Uuh1PjaG";
    String prodPK = "pk_live_51HHa1ZDMvatWijjUL1kMq6lrO90FfY6WN8ycFFCihDiOkNuyMBaT7LqCOEzA4sCGUGZytNDUgMelrV9I0J0SD3LO00HuMYFhQo";

    StripePayment.setOptions(
      StripeOptions(
       //publishableKey: prodPK,
        publishableKey: prod ? prodPK : testPK,
        merchantId: prod ? "info@treinomx.com" : "prod"
      )
    );
  }

  Future<Token> createCard({number, cvc, month, year, name, cp, phone}) async {
    return StripePayment.createTokenWithCard(CreditCard(
      number: number,
      cvc: cvc,
      expMonth: month, 
      expYear: year
    ));
  }

  Future<dynamic> buyMembershipWithCard({String clientId, membershipId, token, codigoPromo,}) async {
    dynamic djson;

    try {
      dynamic body = {
        "codigo":codigoPromo,
        "idCliente": clientId,
        "idMembresia": membershipId,
        "token": token,
	      "idCard": ""
      };
      print(body);
      djson = json.decode((await http.post(  Uri.parse("https://treino.club/demo/api/AppMovil/comprarMembresiaConTarjeta") , body: json.encode(body))).body);
      print(djson);      
    } catch (e) {
      print(e);
    }
    return djson;
  }
  Future<dynamic> buyOneDayPass({String clientId, token,  String idClase, String gymId, String date, String schedule, String fecha_clase}) async {
    dynamic djson;

    try {
      dynamic body = {
        "idCliente": clientId,
        "token": token,
        "idCard": "",
        "idClase":idClase,
        "idGym": gymId,
        "fecha": date,
        "idHorario": schedule,
        "fecha_clase": fecha_clase,
      };
      print(body);
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/comprarOneDayPass") , body: json.encode(body))).body);
      print(djson);
    } catch (e) {
      print(e);
    }
    return djson;
  }
  Future<dynamic> getPointsWithCode({String idCliente, String codigo}) async {
    dynamic djson;

    try {
      dynamic body = {
        "idCliente": idCliente,
        "codigo": codigo,
      };
      print(body);
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/agregarCompraCodigoEmp") , body: json.encode(body))).body);
    } catch (e) {
      print(e);
    }
    return djson;
  }

}