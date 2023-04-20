import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/TabBuscarClase/TabBuscarMap.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:http/http.dart' as http;
import 'package:treino/maps/reservation.dart';
import 'package:treino/membresias/membresias.dart';
import 'package:treino/states/login/login.dart';
import 'package:treino/states/membresias.dart';
import 'package:treino/data/local_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomGymDetail extends StatefulWidget {
  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<CustomGymDetail> {

  Future gymDetails;
  bool canUseIt = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      dynamic gym = ModalRoute.of(context).settings.arguments;
      setState(() {
        this.gymDetails = this.getClassInfo(gymId: gym["gym"]);
      });
    });

    super.initState();
  }

  Future<dynamic> getClassInfo({String gymId}) async {
    dynamic djson;

    try {
      dynamic body = {
        "id": gymId
      };
      print(body);
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getGymByID") , body: json.encode(body))).body);
      print(djson);
    } catch (e) {
      print(e);
    }
    return djson;
  }

  Widget title(String title) {
    return Text(title, style: TextStyle( color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold ));
  }

  Widget content(String c) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 8),
      child: Text(c,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.normal
          ),
          textAlign: TextAlign.center
      ),
    );
  }

  Widget buildService({icon, title, show}){
    return Visibility(
      visible: show,
      child: Expanded(
        flex: 1,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        radius: 40,
                        child: Stack(
                          children: <Widget>[
                            Opacity(
                              opacity: 0.0,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: new BorderRadius.all( Radius.circular(100))
                                  )
                              ),
                            ),
                            Center(
                              child: Image(
                                  width: 60,
                                  height: 60,
                                  image: AssetImage("assets/icons/$icon.png")
                              ),
                            ),
                          ],
                        )
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle( color: Colors.white ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic gym = ModalRoute.of(context).settings.arguments;
    var format = DateFormat('HH:mm:ss');
    var output = DateFormat.jm();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GradientAppBar(title: "title", classDetails: this.gymDetails),
              FutureBuilder(
                future: this.gymDetails,
                builder: (context, snap){
                  if(snap.hasData){
                    var res = snap.data;
                    print(res);
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: title(res['nombre']),
                          ),
                          content(''),
                          title('Informacion del Estudio'),
                          content(res['informacion']),
                          title('Categoria'),
                          content(res['tags']),
                          title('Horario'),
                          content("${res['hora_inicio']} - ${res['hora_fin']}"),

                          title('Qué traer'),
                          content(res['queTraer'] ?? 'Nada'),
                          Padding(
                            padding: const EdgeInsets.only( top: 3.0, bottom: 15.0, left: 15, right: 15 ),
                            child: Text( "Es indispensable traer identificacion oficial para poder ingresar",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15
                                ), textAlign: TextAlign.center ),
                          ),

                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Servicios",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Row(
                                    children: <Widget>[
                                      this.buildService(icon: "showers", title: "Regaderas", show: res["regaderas"] == "1"),
                                      this.buildService(icon: "lockers", title: "Lockers", show: res["lockers"] == "1"),
                                      this.buildService(icon: "valet", title: "Valet", show: res["valet"] == "1"),
                                      this.buildService(icon: "parking", title: "Parking", show: res["parking"] == "1")
                                    ]),
                              ],
                            ),

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [ Color(0xff13e860), Color(0xbf0781e5) ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(0.9, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp
                              ),
                            ),
                          ),


                              res["galeria"].length > 0 ? ListView(
                              primary: false,
                              shrinkWrap: true,
                              children: [
                                  CarouselSlider(
                                    items: res["galeria"].map<Widget>((item) => Container(
                                      child:  Center(
                                          child: Image.network(item, fit: BoxFit.cover, width: 1000)
                                      ),
                                    )).toList(),

                                    options: CarouselOptions(
                                      height: 200.0,
                                      enlargeCenterPage: true,
                                      autoPlay: true,
                                      aspectRatio: 16 / 9,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: false,
                                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                                      viewportFraction: 0.8,
                                    ),
                                  )
                              ],
                            ): Container(
                                    height: 8,
                              ),
                          Container(
                            height: 8,
                          ),
                          title('Contacto: '),
                          content(res['contacto']),

                          title('Direccion: '),
                          content(res['direccion']),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  LocalData.savedPos = LatLng(double.parse(res['latitud']), double.parse(res['longitud']));
                                });
                                Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => MainMenu()));
                              },
                              child: Text("Ver en mapa",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Color(0xbf0781e5))
                              ),
                              color: Color(0xbf0781e5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(child: MinimalLoader());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final Future classDetails;
  final double barHeight = 240.0;

  GradientAppBar({ this.title, this.classDetails });

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: FutureBuilder(
          future: this.classDetails,
          builder: (context, snap) {
            if(snap.hasData){
              var detail = snap.data;
              return Container(
                height: statusbarHeight + barHeight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 29.0, left: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 38,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage( detail["logotipo"] ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
            return Center(child: MinimalLoader());
          }
      ),
    );
  }

}
