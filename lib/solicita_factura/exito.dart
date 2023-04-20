import 'package:flutter/material.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/TabPerfil/TabPerfil.dart';

class ExitoFactura extends StatelessWidget {
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.9, 0.0),
            stops: [0.0, 1],
            colors: [const Color(0xff13e860), Color(0xbf0781e5)],
          ),
        ),
        child: Center(
          child: Container(
            height: 250,
            width: 300,
            child: Card(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text("¡Solicitud Enviada!",
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.blue,
                        decorationColor: Colors.blue)
                      ),
                      ) 
                      
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Center(
                            child: Text("Revisa tu correo"),
                          ),
                           Center(
                            child: Text("Recibiras tu factura electronica"),
                          ),
                           Center(
                            child: Text("En un lapso de 24 a 72 hrs"),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(0.0, -1),
                        child: GestureDetector(
                          child: Text("Ir a mi perfil >"),
                          onTap: () {
                            Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MainMenu()),
                                // MaterialPageRoute(builder: (context) => Membresias()),
                            );
                          },
                        ) 
                          
                      ),
                    ),
                  ],
                ),
              ),
          ),
          ) 
          
        ),
      ),
    );
  }
  
}