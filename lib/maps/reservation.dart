import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/loaders/minimal_loader.dart';

class Reservation extends StatefulWidget {

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  String title;
  String desc;
  bool loading;
  Future reservation;

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      dynamic gym = ModalRoute.of(context).settings.arguments;
      setState(() {
        this.reservation = this.askRegistration(
          gymId: gym["class"]["idGimnasio"],
          classId: gym["class"]["id"],
          clientId: gym["userId"],
          date: gym["date"],
          schedule: gym["schedule"],
          fecha_clase: gym["fecha_selected"],
        );
      });
    });
    super.initState();
  }

  Future<dynamic> askRegistration({String classId, String clientId, String gymId, String date, String schedule, String fecha_clase}) async {
    dynamic djson;

    try {
      dynamic body = {
        "idClase": classId,
        "idGym": gymId,
        "idCliente": clientId,
        "fecha": date,
        "idHorario": schedule,
        "fecha_clase": fecha_clase,
      };
      print(body);
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/agregarSolicitud") , body: json.encode(body))).body);
      print(djson);      
    } catch (e) {
      print(e);
    }
    return djson;
  }

  @override
  Widget build(BuildContext context) {
    dynamic gclass = ModalRoute.of(context).settings.arguments;
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
            FutureBuilder(
              future: this.reservation,
              builder: (context, snap){ 
                if(snap.hasData){
                  dynamic djson = snap.data;
                  if (djson["error"] == "3") {
                   return Align(
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
                          Text(djson["error"] == "3" ? "¡Reserva Existosa!" : "¡Lo sentimos!", textAlign: TextAlign.center, style: TextStyle(color: Color(0xbf0781e5), fontSize: 25, fontWeight: FontWeight.bold)),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(djson["error"] == "3" ? "Tu clase ya fue aceptada. La puedes encontrar en la seccion de mis clases" : djson["descripcion"], textAlign: TextAlign.center),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MainMenu()),
                            ),
                            child: Text( "Ver más clases >" , style: TextStyle(color: Color(0xFF373737), fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                  }else
                  return Align(
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
                          Text(djson["error"] == "0" ? "¡Solicitud\nEnviada!" : "¡Lo sentimos!", textAlign: TextAlign.center, style: TextStyle(color: Color(0xbf0781e5), fontSize: 25, fontWeight: FontWeight.bold)),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(djson["error"] == "0" ? "Espera la confirmación\nde tu reserva para saber\nsi fué confirmada o declinada." : djson["descripcion"], textAlign: TextAlign.center),
                                
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MainMenu()),
                            ),
                            child: Text( "Ver más clases >" , style: TextStyle(color: Color(0xFF373737), fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Center(child: MinimalLoader());
              }
            )
          ],
        ),
      )
    );
  }
}