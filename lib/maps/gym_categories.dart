import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:treino/TabBuscarClase/TabBuscarClasePrimerSub.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:treino/maps/category_classes.dart';
import 'package:treino/states/agregarSolicitudClase.dart';
import 'package:treino/states/classesPerGym.dart';
import 'package:treino/states/gym_coordinates.dart';
import 'package:treino/states/gymsPerCategory.dart';

class GymCategories extends StatefulWidget {

  @override
  _GymCategoriesState createState() => _GymCategoriesState();
}

class _GymCategoriesState extends State<GymCategories> {

  Future gymCategories;

  @override
  void initState() { 
    Future.delayed(Duration.zero, (){
      dynamic gym = ModalRoute.of(context).settings.arguments;
      setState(() {
        this.gymCategories = this.getGymCategories(gymId: gym["idGym"]);
      });
    });

    super.initState();  
  }

  Future<dynamic> getGymCategories({String gymId}) async {    
    dynamic djson;

    try {
      dynamic body = {
        "idGym": gymId
      };
      print(body);
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getCategoriasByIdGym") , body: json.encode(body))).body);
      print(djson);      
    } catch (e) {
      print(e);
    }
    return djson;
  }

  @override
  Widget build(BuildContext context) {

    dynamic gym = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
        children: <Widget>[
          Container(
            child: GradientAppBar("Categorías"),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - (70 + 92), 
            child: FutureBuilder(
              future: this.gymCategories,
              builder: (context, snap){
                print(snap.data);
                if(snap.hasData && snap.data["items"] != null){                     
                  return ListView(
                    children: snap.data["items"].map<Widget>((item) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GymClasses(), settings: RouteSettings(arguments: {
                                        "gymId": gym["idGym"],
                                        "categoryId": item["id"]
                                      })),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 99,
                            child: Text(item["nombre"], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23 )),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item["imagen"])
                              )
                            ),
                          )
                        ),
                      );
                    }).toList()
                  );
                }else{
                  return Center(child: MinimalLoader());
                }
              },
            )
          )
        ],
      ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 70.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                }),
            )
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.title,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [const Color(0xff13e860), Color(0xbf0781e5)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.9, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
