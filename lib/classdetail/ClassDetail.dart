import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/TabBuscarClase/TabBuscarMap.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:treino/states/agregarsolicitudclase/agregarSolicitudClase.dart';
import 'package:treino/states/classDetail.dart';

class ClassDetail extends StatefulWidget {
  @override
  _ClassDetailState createState() => _ClassDetailState();
}

class _ClassDetailState extends State<ClassDetail> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget title(String title) {
    return Text(title,
        style: TextStyle(
            color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget content(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 8),
      child: Text(content,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.normal),
          textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("title"),
            BlocBuilder<ClassDetailCubit, dynamic>(
              builder: (context, res) => res != null
                  ? Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          // Text(res['nombreGimnasio'],
                          //     style: TextStyle(color: Colors.black54, fontSize: 22)),
                          // Text(res['nombreCategoria'],
                          // style: TextStyle(color: Colors.black54, fontSize: 22)),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: title('Acerca de la clase: '),
                          ),
                          content(res['descripcion']),
                          title('Categoria: '),
                          content(res['nombreCategoria']),

                          title('Entrenador: '),
                          content(res['nombreEntrenador']),

                          title('Horario: '),
                          content(res['horario']),

                          title('Qué traer: '),
                          content(res['queTraer']),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 15.0, left: 15, right: 15),
                            child: Text(
                              "Es indispensable traer identificacion oficial para poder ingresar",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Image.network(res['galeria1'])
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
                                Row(
                                    //crossAxisCount: 4,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        foregroundColor:
                                                            Colors.blue,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Opacity(
                                                              opacity: 0.0,
                                                              child: Container(
                                                                  decoration: new BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius: new BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              100)))),
                                                            ),
                                                            Center(
                                                              child: Icon(
                                                                Icons
                                                                    .watch_later,
                                                                size: 40,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        radius: 40,
                                                        backgroundImage: null)
                                                    // NetworkImage(
                                                    //     'https://cdn3.vectorstock.com/i/1000x1000/96/87/dumbbell-in-gym-icon-isolated-contour-vector-28379687.jpg')),
                                                    ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Regaderas",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        foregroundColor:
                                                            Colors.blue,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Opacity(
                                                              opacity: 0.0,
                                                              child: Container(
                                                                  decoration: new BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius: new BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              100)))),
                                                            ),
                                                            Center(
                                                              child: Icon(
                                                                Icons.looks,
                                                                size: 40,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        radius: 40,
                                                        backgroundImage: null)
                                                    // NetworkImage(
                                                    //     'https://cdn3.vectorstock.com/i/1000x1000/96/87/dumbbell-in-gym-icon-isolated-contour-vector-28379687.jpg')),
                                                    ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Lockers",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        foregroundColor:
                                                            Colors.blue,
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Opacity(
                                                              opacity: 0.0,
                                                              child: Container(
                                                                  decoration: new BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius: new BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              100)))),
                                                            ),
                                                            Center(
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 40,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        radius: 40,
                                                        backgroundImage: null)
                                                    // NetworkImage(
                                                    //     'https://cdn3.vectorstock.com/i/1000x1000/96/87/dumbbell-in-gym-icon-isolated-contour-vector-28379687.jpg')),
                                                    ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Valet",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      foregroundColor:
                                                          Colors.blue,
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Opacity(
                                                            opacity: 0.0,
                                                            child: Container(
                                                                decoration: new BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius: new BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            100)))),
                                                          ),
                                                          Center(
                                                            child: Icon(
                                                              Icons
                                                                  .label_important,
                                                              size: 40,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      radius: 40,
                                                      backgroundImage: null)
                                                  // NetworkImage(
                                                  //     'https://cdn3.vectorstock.com/i/1000x1000/96/87/dumbbell-in-gym-icon-isolated-contour-vector-28379687.jpg')),
                                                  ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Parking",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //     bottomLeft: Radius.circular(20),
                              //     bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff13e860),
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
                          content("falta pagina web"),

                          title('Direccion: '),
                          content(res['direccion']),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabBuscarMap()),
                                  // new ClassDetail(),
                                );
                              },
                              child: Text("Ver en mapa",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),

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
                                      borderRadius:
                                          new BorderRadius.circular(28.0),
                                      side:
                                          BorderSide(color: Color(0xbf0781e5))),
                                  color: Color(0xbf0781e5),
                                  onPressed: () async {
                                    bool rpta = false;
                                    showAlertDialog(
                                        context, Stream.value(rpta));
                                    rpta = await context
                                        .read<AgregarSolicitudCubit>()
                                        .agregarSolicitud();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>  ),
                                    // );
                                    print("probando");
                                  }),
                            ),
                          )
                        ],
                      ),
                    )
                  : Center(child: MinimalLoader()),
            ),
          ],
        ),
      ),
    );
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
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 240.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    // Future<bool> _onBackPressed(BuildContext context) {
    //   return Future.value(true);
    // }

    return WillPopScope(
      onWillPop: () {
        context.read<ClassDetailCubit>().reset();
        return Future.value(true);
      },
      child: BlocBuilder<ClassDetailCubit, dynamic>(
          builder: (context, detail) => detail != null
              ? Container(
                  height: statusbarHeight + barHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 29.0, left: 20),
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Center(
                                        child: CircleAvatar(
                                            foregroundColor: Colors.green,
                                            child: Stack(
                                              children: <Widget>[
                                                Opacity(
                                                  opacity: 0.8,
                                                  child: Container(
                                                      decoration: new BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  detail[
                                                                      "fotografia"])),
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      100)))),
                                                ),
                                                Center(
                                                  child: Text("",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25)),
                                                ),
                                              ],
                                            ),
                                            radius: 65,
                                            backgroundImage:
                                                detail['logotipo'] != null
                                                    ? NetworkImage(
                                                        detail['logotipo'])
                                                    : null),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    detail["nombre"]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    detail["nombreGimnasio"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ],
                        ),
                        // Positioned(
                        //   top: 140,
                        //   child: Container(
                        //     child: Center(
                        //       child: CircleAvatar(
                        //           foregroundColor: Colors.green,
                        //           child: Stack(
                        //             children: <Widget>[
                        //               Opacity(
                        //                 opacity: 0.0,
                        //                 child: Container(
                        //                     decoration: new BoxDecoration(
                        //                         color: Colors.blue,
                        //                         borderRadius:
                        //                             new BorderRadius.all(
                        //                                 Radius.circular(100)))),
                        //               ),
                        //               Center(
                        //                 child: Text("",
                        //                     style: TextStyle(
                        //                         color: Colors.black,
                        //                         fontSize: 25)),
                        //               ),
                        //             ],
                        //           ),
                        //           radius: 65,
                        //           backgroundImage: detail['logotipo'] != null
                        //               ? NetworkImage(detail['logotipo'])
                        //               : null),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                    gradient: LinearGradient(
                        colors: [const Color(0xff13e860), Color(0xbf0781e5)],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.9, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: MinimalLoader())),
    );
  }
}
