// import 'dart:html';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/TabBuscarClase/TabBuscarMap.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:http/http.dart' as http;
import 'package:treino/maps/class_detail.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

//las clases
class GymClasses extends StatefulWidget {
  @override
  _GymClassesState createState() => _GymClassesState();
}

class _GymClassesState extends State<GymClasses> {
  var gradesRange = RangeValues(0, 7);
  var contador;
  List letras = [
    {"day": "L", "id": 1},
    {"day": "M", "id": 2},
    {"day": "MI", "id": 3},
    {"day": "J", "id": 4},
    {"day": "V", "id": 5},
    {"day": "S", "id": 6},
    {"day": "D", "id": 0},
  ];

  Future gymClasses;
  Future gymData;
  dynamic gym;
  DateTime date = DateTime.now();
  String fecha_selected;
  String hora;
  String dia;


  int currentClass = 0;

  @override
  void initState() {
    fecha_selected = this.date.add(Duration(days: 0)).year.toString() +
        "-" +
        this.date.add(Duration(days: 0)).month.toString() +
        "-" +
        this.date.add(Duration(days: 0)).day.toString();
    this.hora = DateFormat('HH:mm:ss').format(DateTime.now());
    Future.delayed(Duration.zero, () {
      setState(() {
        //Se imprimen Horas Iniciales
        //print(this.fecha_selected);
        //print(this.hora);
        this.gym = ModalRoute.of(context).settings.arguments;
        this.currentClass = date.weekday - 1;
        this.gymClasses = this.getGymClasses(
            clienteId: gym["clienteId"],
            categoryId: gym["categoryId"],
            day: this.letras[this.currentClass]['id']);
        this.gymData = this.getGymData(gymId: gym["gymId"]);
        this.dia = date.day.toString() + "/" + date.month.toString();
      });
    });

    super.initState();
  }

  Future<dynamic> getGymClasses(
      {String clienteId, String categoryId, int day}) async {
    dynamic djson;

    try {
      dynamic body = {
        "idCliente": clienteId,
        "idCategoria": categoryId,
        "dia": day,
        "fecha": this.fecha_selected,
        "hora": this.hora,
      };
      //Se Imprime el body

     // log('Este es el body que se manda:  ${body}');
      djson = json.decode((await http.post(
              Uri.parse(
                  "https://treino.club/demo/api/AppMovil/getListaClasesByCategoria"),
              body: json.encode(body)))
          .body);
      //log('este es el json que regresa: ${djson}');
    } catch (e) {
      print(e);
    }
    return djson;
  }

  Future<dynamic> getGymData({String gymId}) async {
    dynamic djson;

    try {
      dynamic body = {"id": gymId};
      //print(body);
      djson = json.decode((await http.post(
              Uri.parse("https://treino.club/demo/api/AppMovil/getGymByID"),
              body: json.encode(body)))
          .body);
      // print(djson);
    } catch (e) {
      print(e);
    }
    return djson;
  }

  Widget semanita([DateTime fecha]) {
    var dayOfWeek = 1;
    // var lastMonday = date.subtract(Duration(days: date.weekday - dayOfWeek));

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 14,
          itemBuilder: (BuildContext context, int d) => Column(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () => setState(() {
                      this.currentClass =
                          date.add(Duration(days: d)).weekday - 1;
                      this.dia = date.add(Duration(days: d)).day.toString() +
                          "/" +
                          date.add(Duration(days: d)).month.toString();
                      this.fecha_selected =
                          date.add(Duration(days: d)).year.toString() +
                              "-" +
                              date.add(Duration(days: d)).month.toString() +
                              "-" +
                              date.add(Duration(days: d)).day.toString();
                      this.gymClasses = this.getGymClasses(
                          clienteId: gym["clienteId"],
                          categoryId: gym["categoryId"],
                          day: this.letras[this.currentClass]['id']);
                      this.hora = DateFormat('HH:mm:ss').format(DateTime.now());
                      print(this.fecha_selected);
                      print(this.hora);
                    }),
                    child: Container(
                        height: 60,
                        width: 56,
                        decoration: BoxDecoration(
                            color: Color(0xef0781e5),
                            gradient: this.dia ==
                                    date.add(Duration(days: d)).day.toString() +
                                        "/" +
                                        date
                                            .add(Duration(days: d))
                                            .month
                                            .toString()
                                ? LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [
                                        0.2,
                                        0.8
                                      ],
                                    colors: [
                                        Colors.greenAccent,
                                        Colors.blueAccent
                                      ])
                                : null),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                this.letras[
                                        date.add(Duration(days: d)).weekday - 1]
                                    ["day"],
                                style: TextStyle(color: Colors.white)),
                            Text(
                                date.add(Duration(days: d)).day.toString() +
                                    "/" +
                                    date
                                        .add(Duration(days: d))
                                        .month
                                        .toString(),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ))),
                  ))
                ],
              )),
      /*child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(7, (d) => )
      ),*/
    );
  }

  Widget opciones2(BuildContext context) {
    var format = DateFormat('HH:mm:ss');
    var output = DateFormat.jm();
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: this.gymClasses,
        builder: (context, snap) {
          log('${snap}');
          if (snap.hasData && snap.data["items"] != null) {
            return FutureBuilder(
                future: this.gymData,
                builder: (context, gsnap) {
                  if (gsnap.hasData) {
                    if (snap.data['items'].isEmpty) {
                      return Container(
                          alignment: Alignment.center,
                          width: size.width,
                          height: size.height,
                          child: Text("No hay clases disponibles"));
                    }
                    return ListView(
                      children: snap.data["items"].map<Widget>((clases) {
                        bool isVisible = clases['noseRepite'] == 0;
                        bool full = clases['lugaresAgotados'] == 1;

                        return GestureDetector(
                          onTap: () {
                            if (full) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomClassDetail(),
                                  settings: RouteSettings(arguments: {
                                    "class": clases,
                                    "gym": gsnap.data,
                                    "fecha_selected": this.fecha_selected,
                                  })),
                            );
                          },
                          child: Visibility(
                              visible: isVisible ? true : false,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 110,
                                color: getColor(full, clases['status']),
                                child: Row(
                                  children: [
                                    Opacity(
                                      opacity: full ? 1 : 0,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 32,
                                        height: 110,
                                        margin: EdgeInsets.only(right: 15),
                                        color: Color(0xFFf7aba3),
                                        child: RotatedBox(
                                          quarterTurns: -1,
                                          child: Text("LUGARES AGOTADOS",
                                              style: TextStyle(
                                                  color: Color(0xFFda8c85),
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: true,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: full
                                            ? Color(0xFFf7aba3)
                                            : Colors.blue,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(clases['creditosClase'],
                                                style: TextStyle(
                                                    color: full
                                                        ? Color(0xFFda8c85)
                                                        : Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("Créditos",
                                                style: TextStyle(
                                                    color: full
                                                        ? Color(0xFFda8c85)
                                                        : Colors.white,
                                                    fontSize: 11))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: true,
                                      child: Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(clases['nombreClase'],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(clases['nombreGym'],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12)),
                                              Container(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${output.format(format.parse(clases['hora_inicio']))} - ${output.format(format.parse(clases['hora_fin']))}",
                                                  style: TextStyle(
                                                      color: full
                                                          ? Colors.black54
                                                          : Colors.blue,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Container(
                                                height: 5,
                                              ),
                                              Text(
                                                  "Maestro: ${clases['nombreEntrenadorClase']}",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12)),
                                              /*Text( "Cupo máximo: ${e['cupoMaximo'] ?? 0}",
                                      overflow: TextOverflow .ellipsis,
                                      maxLines: 1,
                                      style: TextStyle( color: Colors.black54, fontSize: 12),
                                    ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(width: 32, height: 100)
                                  ],
                                ),
                              )),
                        );
                      }).toList(),
                    );
                  }
                  return Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height,
                      child: MinimalLoader());
                });
          }
          return Center(child: MinimalLoader());
        });
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay tiempo = TimeOfDay(hour: 00, minute: 00);
    //print(semanita());
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: PreferredSize(child: GradientAppBar(""), preferredSize: Size.fromHeight(70)),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.grey[400],
                width: double.infinity,
                child: Center(
                  child: semanita(),
                ),
              ),
              Expanded(
                child: opciones2(context),
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          overlayOpacity: 0.4,
          children: [
            SpeedDialChild (
              child: Icon(Icons.calendar_today_sharp),
              backgroundColor: Colors.blue,
              onTap: () async {
                DateTime fechon = await showRoundedDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                  borderRadius: 16,
                );
                if (fechon != null) {
                  setState(() {
                    date = fechon;
                    this.currentClass = fechon.weekday - 1;
                    this.dia =
                        fechon.day.toString() + "/" + fechon.month.toString();
                    this.fecha_selected = fechon.year.toString() +
                        "-" +
                        fechon.month.toString() +
                        "-" +
                        fechon.day.toString();
                    this.gymClasses = this.getGymClasses(
                        clienteId: gym["clienteId"],
                        categoryId: gym["categoryId"],
                        day: this.letras[this.currentClass]['id']);
                    print(this.fecha_selected);
                  });
                }
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.access_time),
              backgroundColor: Colors.blue,
              onTap: () async{
              TimeOfDay time =  await showTimePicker(
                  context: context,
                initialTime: tiempo,
                );
              DateTime date = DateFormat.jm().parse("${time.format(context)}");
              String aa = DateFormat('HH:mm:ss').format( date);
              if(aa != null){
                setState(() {
                  this.hora = aa;
                  this.gymClasses = this.getGymClasses(
                      clienteId: gym["clienteId"],
                      categoryId: gym["categoryId"],
                      day: this.letras[this.currentClass]['id']);
                  print(this.hora);
                });
              }
              //print("${DateFormat('HH:mm:ss').format(DateTime.now())}");
              }
            )
          ],
          child: Icon(Icons.list),
          backgroundColor: Colors.blue,
        ),
      ),

    );

  }

}

class GradientAppBar extends StatefulWidget {
  final String title;

  GradientAppBar(this.title);

  @override
  _GradientAppBarState createState() => _GradientAppBarState();
}



class _GradientAppBarState extends State<GradientAppBar> {
  final double barHeight = 70.0;
  _GymClassesState asi;
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(
                    context,
                    // new ClassDetail(),
                  );
                }),
          ),
          Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 240,top: 0,right: 0,bottom: 0),
                child: MaterialButton(
                  minWidth: 2,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainMenu(),
                            settings: RouteSettings(arguments: {
                              "tab": 1,
                              "move": 1,
                            })));
                  },
                  child: Center(
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          )
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


Color getColor(full, status) {
  if (status == 1) {
    return Colors.greenAccent[100];
  } else if (full) {
    return Color(0xFFffd8d5);
  } else {
    return Colors.grey[200];
  }
}
