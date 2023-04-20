import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treino/creditos/creditos.dart';
import 'package:treino/data/local_data.dart';
import 'package:treino/login/login.dart';
import 'package:treino/membresias/membresias.dart';
import 'package:treino/solicita_factura/solicita_factura.dart';
import 'package:treino/states/login/login.dart';
import 'package:treino/states/membership/membresiacubit.dart';
import 'package:treino/states/membership/membresiastate.dart';
import 'package:treino/states/tabperfil/tabperfil.dart';
import 'package:treino/webview/webview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:treino/states/membresias.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class TabPerfil extends StatefulWidget {
  @override
  _TabPerfilState createState() => _TabPerfilState();
}

class _TabPerfilState extends State<TabPerfil> {

  Widget link(String name, Function func) {
    return MaterialButton(
        child: Padding(
          padding: const EdgeInsets.only(left: 19.0, right: 19),
          child: FlatButton(
            onPressed: func,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: 3, // space between underline and text
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.black38, // Text colour here
                width: 1.0, // Underline width
              ))),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black54, // Text colour here
                ),
              ),
            ),
          ),
        ),
        onPressed: () {
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
      return Future.value(true);
    },
    child: Scaffold(
    appBar: PreferredSize(child: GradientAppBar(), preferredSize: new Size.fromHeight(125),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Center(
                    child: Text(
                  "DATOS DE CUENTA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue,
                      decorationColor: Colors.blue),
                )),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: link("Membresía", () async {
                    await context.read<MembresiasCubit>().getMembresias();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Membresias()));
                  })),
                  Align(
                  alignment: Alignment.bottomLeft,
                  child: link("Créditos", () async {
                    await context.read<MembresiasCubit>().getMembresias();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Creditos()));
                  })),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: link("Solicita tu factura", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SolicitaFactura()));
                  })),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Center(
                    child: Text(
                  "MÁS INFORMACIÓN",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue,
                      decorationColor: Colors.blue),
                )),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: link("Preguntas Frecuentes", () async {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          WebviewLoader(), settings: RouteSettings(arguments: {
                            "title": "Preguntas Frecuentes",
                            "url": "https://treino.club/demo/home/preguntasFrecuentes"
                          }
                        )
                      ),
                    );
                  })),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: link("Términos y condiciones", () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          WebviewLoader(), settings: RouteSettings(arguments: {
                            "title": "Términos y condiciones",
                            "url": "https://treino.club/demo/home/terminosCondiciones"
                          }
                        )
                      ),
                    );
                  })),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: link("Política de privacidad", () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          WebviewLoader(), settings: RouteSettings(arguments: {
                            "title": "Política de privacidad",
                            "url": "https://treino.club/demo/home/politicaPrivacidad"
                          }
                        )
                      ),
                    );
                  })),
              Align(alignment: Alignment.bottomLeft, child: link("Ayuda", () async{
                final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'info@treino.club',
                  queryParameters: {
                    'subject': 'Ayuda'
                  }
                );
                // mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
               print(_emailLaunchUri.toString());
               await launch(_emailLaunchUri.toString());
              })),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 17, left: 85, right: 85),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                      elevation: 5,
                      child: Text(
                        "Comprar membresia",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(28.0),
                          side: BorderSide(color: Color(0xff0781e5))),
                      color: Color(0xff0781e5),
                      onPressed: () async {
                        await context.read<MembresiasCubit>().getMembresias();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Membresias()));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 25, left: 85, right: 85),
                child: Container(
                  height: 50,
                  width: 150,
                  child: RaisedButton(
                      elevation: 5,
                      child: Text(
                        "Cerrar sesión",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(28.0),
                          side: BorderSide(color: Color(0xff0781e5))),
                      color: Color(0xff0781e5),
                      onPressed: () async {
                        await LocalData.db.removeUser();
                        context.read<LoginCubit>().restoreState();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }

  _launchURL(String linki) async {
    String url = linki;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


class GradientAppBar extends StatefulWidget {
  @override
  _GradientAppBarState createState() => _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {
  final double barHeight = 200.0;
  
  var _imageFile;
  String _avatar = 'https://journeypurebowlinggreen.com/wp-content/uploads/2018/05/placeholder-person.jpg';
  Future credits;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var user = context.read<LoginCubit>().res;
      this._imageFile = NetworkImage(_avatar);
      
      var errorMsg = "Failed loading the image, using fallback instead!";

      if(user["fotoPerfil"] != null){
        var userImage = Uri.encodeFull(user["fotoPerfil"]);
        var usIma = Uri.parse(userImage);
        try{
          final response = await http.get(usIma);

          if (response.statusCode == 200)
            setState(() {
              this._imageFile = NetworkImage(userImage);
            });
          else print(errorMsg);
        }catch(_){
          print(errorMsg);
        }
      }      
    });
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
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getCreditosGastados") ,
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
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return FutureBuilder(
      future: this.credits,
        builder: (context, snapshot){
      if(snapshot.hasData){
        return Container(
          // padding: EdgeInsets.only(top: statusbarHeight),
          height: statusbarHeight + barHeight,
          child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child:
              Center(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              context.read<LoginCubit>().res["nombre"] +
                                  " " +
                                  context.read<LoginCubit>().res["apellidos"],
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Créditos Disponibles: ${snapshot.data["items"]["creditosDisponibles"].toString()}",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              context.read<LoginCubit>().res["correo"],
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          BlocConsumer<MembresiaCubit, MembresiaState>(
                            listener: (context, state){},
                            builder: (context, state){

                              if(state is InitState){
                                context.read<MembresiaCubit>().getMembresia(
                                    context.read<LoginCubit>().res["id"]
                                );
                              }

                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (state is Success) ? "Membresia: ${state.name}" : "Membresia:",
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (state is Success) ? "Expira: ${state.date}" : "Expira:",
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                colors: [const Color(0xff13e860), Color(0xbf0781e5)],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.9, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        );
      }
      return Container(
        // padding: EdgeInsets.only(top: statusbarHeight),
        height: statusbarHeight + barHeight,
        child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child:
            Center(
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            context.read<LoginCubit>().res["nombre"] +
                                " " +
                                context.read<LoginCubit>().res["apellidos"],
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Créditos Disponibles: -",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            context.read<LoginCubit>().res["correo"],
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        BlocConsumer<MembresiaCubit, MembresiaState>(
                          listener: (context, state){},
                          builder: (context, state){

                            if(state is InitState){
                              context.read<MembresiaCubit>().getMembresia(
                                  context.read<LoginCubit>().res["id"]
                              );
                            }

                            return Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    (state is Success) ? "Membresia: ${state.name}" : "Membresia:",
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    (state is Success) ? "Expira: ${state.date}" : "Expira:",
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          gradient: LinearGradient(
              colors: [const Color(0xff13e860), Color(0xbf0781e5)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.9, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      );

        }

    );
  }
}
