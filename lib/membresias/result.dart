import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/loaders/minimal_loader.dart';

class BuyResult extends StatefulWidget {

  @override
  _BuyResultState createState() => _BuyResultState();
}

class _BuyResultState extends State<BuyResult> {      

  @override
  Widget build(BuildContext context) {
    dynamic djson = ModalRoute.of(context).settings.arguments;
    
    return SafeArea(
      child: Scaffold(        
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xff13e860), Color(0xbf0781e5)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.9, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(djson["error"] == "0" ? "¡Tu compra se ha procesado correctamente!" : "¡Lo sentimos!", textAlign: TextAlign.center, style: TextStyle(color: Color(0xbf0781e5), fontSize: 25, fontWeight: FontWeight.bold)),
                    Text(djson["error"] == "0" ? "Has hecho la\ncompra correctamente" : djson["descripcion"], textAlign: TextAlign.center),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenu()),
                      ),
                      child: Text("Regresar al menu principal >", style: TextStyle(color: Color(0xFF373737), fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}