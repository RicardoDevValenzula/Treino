// import 'dart:html';

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treino/classdetail/ClassDetail.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:treino/states/agregarsolicitudclase/agregarSolicitudClase.dart';
import 'package:treino/states/classDetail.dart';
import 'package:treino/states/classesPerGym.dart';
import 'package:treino/states/gymsPerCategory.dart';
import 'TabBuscarClase.dart';
import 'TabBuscarMap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//las clases
class TabBuscarClasePrimerSub extends StatefulWidget {
  @override
  _TabBuscarClasePrimerState createState() => _TabBuscarClasePrimerState();
}

class _TabBuscarClasePrimerState extends State<TabBuscarClasePrimerSub> {
  var gradesRange = RangeValues(0, 7);
  List letras = ["D", "L", "M", "M", "J", "V", "S", "ads"];
  Widget semana() {
    return Container(
      height: 80,
      color: Colors.black87,
      child: GridView.builder(
        // physics: NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return RaisedButton(
            color: Color(0xef0781e5),
            onPressed: () {
              print("ads");
            },
            child: Container(
              width: 100,
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      letras[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "/",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget day(String day) {
    return Expanded(
        child: Container(
            height: 50,
            color: Color(0xef0781e5),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                    DateTime.now().day.toString() +
                        "/" +
                        DateTime.now().month.toString(),
                    style: TextStyle(color: Colors.white)),
              ],
            ))));
  }

  Widget semanita() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          day("D"),
          day("L"),
          day("M"),
          day("M"),
          day("J"),
          day("V"),
          day("S"),
        ],
      ),
    );
  }

  Widget opciones() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 24.0,
          mainAxisSpacing: 7.0,
          childAspectRatio: 4.5),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[200],
          child: MaterialButton(
            // color: Colors.grey[200],
            // minWidth: double.infinity,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassDetail()),
                // new ClassDetail(),
              );
              // print("dasd");
            },
            child: Container(
              // width: ,
              height: 140,
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      // "index: $index",
                      "12:00 pm - 120 min",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("Acceso Libre"),
                  Text("Sports World Prado Sur"),
                  Text("Maestro : N/A"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget opciones2(BuildContext context) {
    return BlocBuilder<ClassesPerGymCubit, List<dynamic>>(
        builder: (context, val) => val != null
            ? Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
                child: Column(
                  // crossAxisCount: val.length,
                  children: val
                      .map((e) => (e['idCategoria'] ==
                              context
                                  .read<GymsPerCategoryCubit>()
                                  .idCategoriaSeleccionado)
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  FlatButton(
                                    // minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      //setea la id de clase para la compra
                                      context
                                          .read<AgregarSolicitudCubit>()
                                          .setIdClase(e['idClase']);

                                      //setea los detalles de clase
                                      context
                                          .read<ClassDetailCubit>()
                                          .getClaseByID(e['idClase']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ClassDetail()),
                                      );
                                      print("as");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, bottom: 16.0),
                                      child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                        color: Colors.grey[200],
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                      child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          e['creditosClase'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          "Créditos",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    // color: Colors.tealAccent,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          e['horarioClase'] +
                                                              "-" +
                                                              e['duracionClase'] +
                                                              "m",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Container(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          e['descripcionClase'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                        Text(e['nombreClase'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54)),
                                                        Text(
                                                            "entrenador :" +
                                                                e[
                                                                    'nombreEntrenadorClase'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54)),
                                                        // Text(e['nombreCategoria']),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(flex: 1,child: Container())
                                              ],
                                            ),
                                            // Container(
                                            //     width:
                                            //         MediaQuery.of(context).size.width,
                                            //     height: 4,
                                            //     color: Colors.white),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 3,
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                ],
                              ),
                            )
                          : Container())
                      .toList(),
                ),
              )
            : MinimalLoader());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<ClassesPerGymCubit>().reset();
        return Future.value(true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // scrollDirection: Axis.vertical,
            // physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: GradientAppBar("buscando"),
              ),
              semanita(),
              Container(
                height: 30,
                color: Colors.grey[400],
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Seleccione una Clase",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              //     // opciones(),
              //     BlocBuilder<ExternalControllerMisClasesCubit, int>(
              //   builder: (context, val) => val==1? ),
              // ),
              opciones2(context)
            ],
          ),
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
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      // new ClassDetail(),
                    );
                  }),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: TextField(
                        decoration: null,
                      )),
                    ),
                    height: 35,
                    // width: 200,
                    decoration: BoxDecoration(
                        // border:,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: MaterialButton(
                  minWidth: 3,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabBuscarMap()),
                      // new ClassDetail(),
                    );
                    print("as");
                  },
                  child: Center(
                      child: Icon(
                    Icons.place,
                    size: 30,
                    color: Colors.white,
                  )
                      // Text(
                      //   "Search",
                      //   style: TextStyle(
                      //       fontSize: 25.0,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   flex: 2,
          //   child: Container(
          //     child: Padding(
          //       padding: const EdgeInsets.all(0.0),
          //       child: FlatButton(
          //         //  minWidth: 2,
          //         onPressed: () {
          //           print("as");
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => TabBuscarClase()),
          //             // MaterialPageRoute(builder: (context) => Membresias()),
          //           );
          //         },
          //         child: Center(
          //             child: Icon(
          //           Icons.tune,
          //           size: 25,
          //           color: Colors.white,
          //         )
          //             // Text(
          //             //   "Search",
          //             //   style: TextStyle(
          //             //       fontSize: 25.0,
          //             //       color: Colors.white,
          //             //       fontWeight: FontWeight.bold),
          //             // ),
          //             ),
          //       ),
          //     ),
          //   ),
          // ),
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
