import 'dart:convert';

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
import 'package:treino/membresias/oneDayPass.dart';
import 'package:treino/states/login/login.dart';
import 'package:treino/states/membresias.dart';
import 'package:treino/data/local_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:treino/maps/gym_detail.dart';

class CustomClassDetail extends StatefulWidget {
  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<CustomClassDetail> {
  Future classDetails;
  bool canUseIt = true;
  String fecha;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      dynamic gym = ModalRoute.of(context).settings.arguments;
      setState(() {
        this.fecha = gym["fecha_selected"];
        print(this.fecha);
        print(gym);
        this.classDetails = this.getClassInfo(
            classId: gym["class"]["idClase"],
            idhorario: gym["class"]["idHorario"]);
      });
    });

    super.initState();
  }

  Future<dynamic> getClassInfo({String classId, String idhorario}) async {
    dynamic djson;
    print("este es el horario algo bien" + idhorario);
    try {
      dynamic body = {
        "id": classId,
        "idHorario": idhorario,
        "idCliente": context.read<LoginCubit>().res["id"],
        "fecha": this.fecha,
      };
      djson = json.decode((await http.post(
              Uri.parse("https://treino.club/demo/api/AppMovil/getClaseByID"),
              body: json.encode(body)))
          .body);
    } catch (e) {
      print(e);
    }
    return djson;
  }

  Widget title(String title) {
    return Text(title,
        style: TextStyle(
            color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget content(String c) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 8),
      child: Text(c,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.normal),
          textAlign: TextAlign.center),
    );
  }

  Widget buildService({icon, title, show}) {
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
                                      borderRadius: new BorderRadius.all(
                                          Radius.circular(100)))),
                            ),
                            Center(
                              child: Image(
                                  width: 60,
                                  height: 60,
                                  image: AssetImage("assets/icons/$icon.png")),
                            ),
                          ],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
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
              GradientAppBar(title: "title", classDetails: this.classDetails),
              FutureBuilder(
                future: this.classDetails,
                builder: (context, snap) {
                  if (snap.hasData) {
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomGymDetail(),
                                      settings: RouteSettings(arguments: {
                                        "class": res['id'],
                                        "gym": res['idGym']
                                      })),
                                );
                              },
                              child: Text(res['nombreGimnasio'],
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Color(0xbf0781e5))),
                              color: Color(0xbf0781e5),
                            ),
                          ),
                          title('Acerca de la clase'),
                          content(res['descripcion']),
                          title('Categoria'),
                          content(res['nombreCategoria']),
                          title('Entrenador'),
                          content(res['nombreEntrenador']),
                          title('Horario'),
                          content(
                              "${output.format(format.parse(res['hora_inicio']))} - ${output.format(format.parse(res['hora_fin']))}"),
                          title('Qué traer'),
                          content(res['queTraer'] ?? 'Nada'),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 15.0, left: 15, right: 15),
                            child: Text(
                                "Es indispensable traer identificacion oficial para poder ingresar",
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 15),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Servicios",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                Row(children: <Widget>[
                                  this.buildService(
                                      icon: "showers",
                                      title: "Regaderas",
                                      show: res["regaderas"] == "1"),
                                  this.buildService(
                                      icon: "lockers",
                                      title: "Lockers",
                                      show: res["lockers"] == "1"),
                                  this.buildService(
                                      icon: "valet",
                                      title: "Valet",
                                      show: res["valet"] == "1"),
                                  this.buildService(
                                      icon: "parking",
                                      title: "Parking",
                                      show: res["parking"] == "1")
                                ]),
                              ],
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff13e860),
                                    Color(0xbf0781e5)
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(0.9, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
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
                                  LocalData.savedPos = LatLng(
                                      double.parse(res['latitud']),
                                      double.parse(res['longitud']));
                                });
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainMenu()));
                              },
                              child: Text("Ver en mapa",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0),
                                  side: BorderSide(color: Color(0xbf0781e5))),
                              color: Color(0xbf0781e5),
                            ),
                          ),
                          (res['mismoDia'] == true)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child: RaisedButton(
                                      onPressed: () {
                                        var id = context
                                            .read<LoginCubit>()
                                            .res["id"];
                                        int hid = 0;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PagarMembresia(),
                                              settings:
                                                  RouteSettings(arguments: {
                                                "idClase": res["id"],
                                                "userId": id,
                                                "class": res,
                                                "schedule": res['idHorario'],
                                                "date": DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.now()),
                                                "fecha_clase": 1,
                                                "fecha_selected":
                                                    gym["fecha_selected"] +
                                                        " " +
                                                        res['horarios'][0]
                                                            ['hora_fin'],
                                              })),
                                        );
                                      },
                                      child: Text(
                                          "One Day Pass - " +
                                              (90 * int.parse(res["creditos"]))
                                                  .toString() +
                                              "\$",
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28.0),
                                          side: BorderSide(
                                              color: Color(0xbf0781e5))),
                                      color: Color(0xbf0781e5),
                                    ),
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: Container(
                                    width: 0,
                                    height: 0,
                                  )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 28.0),
                            child: Container(
                              width: 220,
                              height: 50,
                              child: RaisedButton(
                                  child: Text(
                                    "Reservar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                      side:
                                          BorderSide(color: Color(0xbf0781e5))),
                                  color: Color(0xbf0781e5),
                                  onPressed: () async {
                                    if (int.parse(
                                            res["num_usuario_mismo_gym"]) > 5) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "No es posible reservar 5 clases en el mismo estudios",
                                        toastLength: Toast.LENGTH_SHORT,
                                        textColor: Colors.black,
                                        fontSize: 16,
                                        backgroundColor: Colors.grey[200],
                                      );
                                      return;
                                    }
                                    if (!this.canUseIt) return;

                                    //Maximo 7 clases en total por semana.

                                    setState(() => this.canUseIt = false);

                                    int hid = 0;
                                    var id =
                                        context.read<LoginCubit>().res["id"];
                                    var credits = (await this
                                        .getCreditosCliente(
                                            userId: id))["creditos"];
                                    var currentCredits = int.parse("$credits");
                                    var neededCredits =
                                        int.parse(res['creditos']);

                                    print(currentCredits);
                                    print(neededCredits);

                                    if (neededCredits > currentCredits) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: Text("Aviso",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff0781e5))),
                                              content: Text(
                                                  "No tienes creditos suficientes.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff0781e5))),
                                              actions: [
                                                CupertinoDialogAction(
                                                  child: Text("Aceptar",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                CupertinoDialogAction(
                                                  child: Text("Comprar",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff0781e5))),
                                                  onPressed: () async {
                                                    await context
                                                        .read<MembresiasCubit>()
                                                        .getMembresias();
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Membresias()));
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                      return;
                                    } else if (res['status'] == 1) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: Text("Aviso",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff0781e5))),
                                              content: Text(
                                                  "No es posible reservar la misma clase mas de una vez",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff0781e5))),
                                              actions: [
                                                CupertinoDialogAction(
                                                  child: Text("Aceptar",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            );
                                          });
                                      return;
                                    } else {
                                      print(this.fecha);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Reservation(),
                                            settings: RouteSettings(arguments: {
                                              "userId": id,
                                              "class": res,
                                              "schedule": res['idHorario'],
                                              "date": DateFormat('dd-MM-yyyy')
                                                  .format(DateTime.now()),
                                              "fecha_clase": 1,
                                              "fecha_selected":
                                                  gym["fecha_selected"] +
                                                      " " +
                                                      res['horarios'][0]
                                                          ['hora_fin']
                                            })),
                                      );
                                    }
                                    setState(() => this.canUseIt = true);
                                  }),
                            ),
                          )
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

  Future<dynamic> getCreditosCliente({userId}) async {
    dynamic djson;

    try {
      dynamic body = {"id": userId};
      print(body);
      djson = json.decode((await http.post(
              Uri.parse(
                  "https://treino.club/demo/api/AppMovil/getCreditosCliente"),
              body: json.encode(body)))
          .body);
      print(djson);
    } catch (e) {
      print(e);
    }
    return djson;
  }

  showAlertDialog(BuildContext context, Stream def) async {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Estado"),
      content: Text("suscripcion exitosa"),
      actions: [
        okButton,
      ],
    );

    AlertDialog cargando = AlertDialog(
      title: Text("Estado"),
      content: Text("enviando suscripcion"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
            stream: def,
            builder: (context, snap) {
              if (snap.data == true) {
                print("tu vieja");
                return alert;
              } else {
                print("la tuya");
                return cargando;
              }
            });
      },
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final Future classDetails;
  final double barHeight = 240.0;

  GradientAppBar({this.title, this.classDetails});

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: FutureBuilder(
          future: this.classDetails,
          builder: (context, snap) {
            if (snap.hasData) {
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
                                  }),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(detail["logotipo"]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
            return Center(child: MinimalLoader());
          }),
    );
  }
}
