import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PayMembresiasCubit extends Cubit<int> {
  PayMembresiasCubit() : super(null);
  var response;
  String idMembresiaSelected = "-";
  String idCliente = "-";
  String idCard = "-";
  String token = "-";

  void setIdCliente(String id) async {
    this.idCliente = id;
    print("recibido : " + idCliente);
  }

  void setIdMembresia(String id) async {
    this.idMembresiaSelected = id;
    print("membresia : " + idMembresiaSelected);
  }

  void setIdCard(String id) async {
    this.idCard = id;
    print("card : " + idCard);
  }

  void setToken(String id) async {
    this.token = id;
    print("token : " + token);
  }

  void payMembresia({String idCli, String idMembre}) async {
    // print("parametros de compra > " +
    //     "cliente " +
    //     this.idCliente +
    //     " || " +
    //     "id membresia " +
    //     this.idMembresiaSelected);
    print("----compra----");
    print("token :" + this.token);
    print("idCard :" + this.idCard);
    print("idCliente :" + this.idCliente);
    print("idMembresia :" + this.idMembresiaSelected);

    var dio = Dio();
    try {
       StripePayment.setOptions(
        StripeOptions(
          publishableKey: "pk_test_51HHa1ZDMvatWijjUr4R4KGpw5HNa0PhCr1houTTdRnZn3A68kJk05Y0SsgdbrP0yGXi86FaFbLug7ah9B4ElFVf000Uuh1PjaG",
          merchantId: "Test",
          androidPayMode: "test"
        )
      );
            
      var paymentMethod = StripePayment.createPaymentMethod(PaymentMethodRequest(
        card: CreditCard(
          number: '4000002500003155',
          cvc: "123",
          expMonth: 11,
          expYear: 2020
        )
      ));
      /*await dio.post(
          "https://treino.club/demo/api/AppMovil/comprarMembresiaConTarjeta",
          data: {
            "idMembresia": this.idMembresiaSelected,
            "idCliente": this.idCliente,
            "idCard": this.idCard,
            "token": this.token
          }).then((value) {
        print(value.data);
        this.response = (json.decode(value.data));
        if (this.response['error'] == "0") {
          print("compra de membresia exitosa");
        } else {
          print("error al comprar membresia");
        }
      });*/
    } catch (e) {
      print(e);
    }
  }
}
