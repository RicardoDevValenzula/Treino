import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:treino/states/login/login.dart';
import 'package:http/http.dart' as http;


class Creditos extends StatefulWidget {

  @override
  _CreditosState createState() => _CreditosState();

}

class _CreditosState extends State<Creditos> {

  Future credits;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        this.credits = this.getUserCredits(context.read<LoginCubit>().res["id"]);
      });
    });
    super.initState();
  }

  Future getUserCredits(String idCliente) async {
    dynamic djson;
    try{
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getCreditosGastados"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"idCliente": "$idCliente"})
      )).body);
      print("---------------------------------------------------------------------------------");
      print(djson);
      print("---------------------------------------------------------------------------------");
    } catch (e) {
      print(e);
    }

    return djson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: this.credits,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 75,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.8],
                          colors: [Colors.greenAccent, Colors.blueAccent]
                        )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment(-1,0.2),
                              child: BackButton(
                                color: Colors.white,
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                            children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment(0.0, 1),
                                    child: Text(snapshot.data["items"]["creditosDisponibles"].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue
                                      )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text("Créditos Disponibles",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue
                                      )
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment(0.0, 1),
                                    child: Text(snapshot.data["items"]["creditosGastados"].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue
                                      )
                                    ),
                                  )
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text("Créditos Gastados",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue
                                      )
                                    )
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      )
                    ),
                    Container(
                      color: Colors.grey[400],
                      width: double.infinity,
                      child: Wrap(
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        spacing: 40,
                        children: [
                          Text( "Clase", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17) ),
                          Text( "Créditos Gastados", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17) ),
                          Text( "Fecha", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17) ),
                        ],
                      ),
                    ),
                    if(snapshot.data["items"]["clases"].isNotEmpty)
                    ListView.builder(
                      padding: const EdgeInsets.all(8),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data["items"]["clases"].length,
                      itemBuilder: (BuildContext context, int index) {
                      if(index >= snapshot.data["items"]["clases"].length) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60.0,
                                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blueAccent,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 80,
                          color: Colors.black12,
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(10, 2, 0, 2),
                                    child: Text("${snapshot.data["items"]["clases"][index]['nombreClase']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue)
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text("${snapshot.data["items"]["clases"][index]["creditos"]}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text("${snapshot.data["items"]["clases"][index]["fecha"]}"),
                                  ),
                                ),
                              ],
                            )
                          ),
                        );
                      }
                    )
                    else
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("No se encontraron resultados",
                          style: TextStyle(
                            fontSize: 18
                          )
                        ),
                      )
                    )
                  ]
                ),
              );
            }
            return Center(child: MinimalLoader());
          }
        )
      ),
    );
  }
}