import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/externalcontroltab/externalControlTab.dart';
import 'package:treino/states/externalcontroltab/externalcontroltabstates.dart';
import 'package:treino/states/getSolicitudes.dart';
import 'package:treino/states/getSolicitudesPasadas.dart';
import 'package:treino/states/login/login.dart';
import 'package:intl/intl.dart';

class TabMisClases extends StatefulWidget {
  @override
  _TabMisClasesState createState() => _TabMisClasesState();
}

bool controlClasesVista = false;

class _TabMisClasesState extends State<TabMisClases> {
  static int tabdinamic;
  @override
  void initState() {
    super.initState();
  }

  Widget reservadas(BuildContext context) {
    return BlocBuilder<SolicitudesCubit, List<dynamic>>(
      builder: (context, items) => items != null
          ? Column(
              children: items.map((e) => Text(e['numeroControl'])).toList(),
            )
          : Text("cargando"),
    );
  }

  Widget pasadas(BuildContext context) {
    return BlocBuilder<SolicitudesPasadasCubit, List<dynamic>>(
      builder: (context, items) => items != null
          ? Column(
              children: items.map((e) => Text(e['numeroControl'])).toList(),
            )
          : Text("cargando"),
    );
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('HH:mm:ss');
    var output = DateFormat.jm();
    dynamic arg = ModalRoute.of(context).settings.arguments;
    var move = arg ?? null;
    if (move != null) {
      if (arg["move"] == 2) {
        context
            .read<ExternalControllerMisClasesCubit>()
            .getClasesPasadas(context.read<LoginCubit>().res['id']);
        tabdinamic = 2;
      } else {
        context
            .read<ExternalControllerMisClasesCubit>()
            .getClases(context.read<LoginCubit>().res['id']);
        tabdinamic = 1;
      }
    } else {
      context
          .read<ExternalControllerMisClasesCubit>()
          .getClases(context.read<LoginCubit>().res['id']);
      tabdinamic = 1;
    }

    return //Demo();
        WillPopScope(
            onWillPop: () {
              return Future.value(true);
            },
            child: Scaffold(
                appBar: PreferredSize(
                  child: GradientAppBar(""),
                  preferredSize: new Size.fromHeight(80),
                ),
                body: ListView(
                  //Header de los tabs
                  // physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    CustomTabSelector(),
                    /*Container(
            color: Colors.grey[400],
            width: double.infinity,
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 40,
              children: [
                Text(
                  "Número de reserva",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Valor Total",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                Text(
                  "Status",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),*/
                    BlocBuilder<ExternalControllerMisClasesCubit,
                        ExternalControllTabState>(
                      builder: (context, state) {
                        if (state is InitState) {
                          context
                              .read<ExternalControllerMisClasesCubit>()
                              .getClases(context.read<LoginCubit>().res['id']);
                          tabdinamic = 1;
                        }

                        if (state is Success) {
                          if (state.list.length == 0) {
                            return Container(
                              alignment: Alignment(0.0, 1),
                              padding: const EdgeInsets.only(top: 20),
                              child: Text("No se encontraron resultados"),
                            );
                          }

                          return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              physics: NeverScrollableScrollPhysics(),

                              ///
                              shrinkWrap: true,

                              ///
                              scrollDirection: Axis.vertical, //
                              itemCount: state.list.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index >= state.list.length) {
                                  return Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 60.0,
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 12.0, 0.0, 12.0),
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.blueAccent,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                if (tabdinamic == 1) {
                                  String date = DateFormat(
                                    "yyyy-MM-dd",
                                  ).format((DateFormat(
                                    "dd-MM-yyyy",
                                  ).parse((state.list[index].fecha)
                                      .replaceAll("/", "-"))));
                                  String claseDateTime =
                                      "${date} ${state.list[index].hora_inicio}";

                                  if (!state.list[index].status
                                          .contains("CANCELADA") &&
                                      state.list[index].onedaypass == "1") {
                                    return Dismissible(
                                      background: Container(
                                        color: Colors.red,
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 32,
                                            height: 120,
                                            margin: EdgeInsets.only(right: 15),
                                            color: Color(0xFFf7aba3),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Text("Cancelar",
                                                  style: TextStyle(
                                                      color: Color(0xFFda8c85),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                Text(
                                                    "${output.format(format.parse(state.list[index].hora_inicio))} - ${output.format(format.parse(state.list[index].hora_final))}",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "${state.list[index].fecha}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${state.list[index].nombre_gym}",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                    "${state.list[index].nombre_clase}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "Creditos: ${state.list[index].value}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blue,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "Status:  ${state.list[index].status}",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: (state
                                                                    .list[index]
                                                                    .status ==
                                                                "CANCELADA")
                                                            ? Colors.redAccent
                                                            : (state.list[index]
                                                                        .status ==
                                                                    "ACEPTADA")
                                                                ? Colors.greenAccent[
                                                                    100]
                                                                : Colors
                                                                    .blueGrey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "${state.list[index].number}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                  "",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
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
                                                    "No es posible cancelar eventos One Day Pass ",
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
                                                              color: Color(
                                                                  0xff0781e5))),
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              );
                                            });
                                      },
                                    );
                                  } else if (!state.list[index].status
                                          .contains("CANCELADA") &&
                                      (DateTime.now()
                                              .add(new Duration(hours: 2)))
                                          .isBefore(
                                              DateTime.parse(claseDateTime))) {
                                    return Dismissible(
                                      background: Container(
                                        color: Colors.red,
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 32,
                                            height: 120,
                                            margin: EdgeInsets.only(right: 15),
                                            color: Color(0xFFf7aba3),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Text("Cancelar",
                                                  style: TextStyle(
                                                      color: Color(0xFFda8c85),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                Text(
                                                    "${output.format(format.parse(state.list[index].hora_inicio))} - ${output.format(format.parse(state.list[index].hora_final))}",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "${state.list[index].fecha}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${state.list[index].nombre_gym}",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                    "${state.list[index].nombre_clase}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "Creditos: ${state.list[index].value}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blue,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "Status:  ${state.list[index].status}",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: (state
                                                                    .list[index]
                                                                    .status ==
                                                                "CANCELADA")
                                                            ? Colors.redAccent
                                                            : (state.list[index]
                                                                        .status ==
                                                                    "ACEPTADA")
                                                                ? Colors.greenAccent[
                                                                    100]
                                                                : Colors
                                                                    .blueGrey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "${state.list[index].number}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                  "",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
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
                                                    "¿Seguro que quiere cancelar la clase?",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff0781e5))),
                                                actions: [
                                                  CupertinoDialogAction(
                                                      child: Text("Cancelar",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      }),
                                                  CupertinoDialogAction(
                                                    child: Text("Aceptar",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff0781e5))),
                                                    onPressed: () async {
                                                      //Remueve el Item de la lista
                                                      context
                                                          .read<
                                                              ExternalControllerMisClasesCubit>()
                                                          .cancelarSolicitud(
                                                              state.list[index]
                                                                  .id);
                                                      Navigator.pop(context);
                                                      setState(() {});
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                    );
                                  } else if (!state.list[index].status
                                          .contains("CANCELADA") &&
                                      !(DateTime.now()
                                              .add(new Duration(hours: 2)))
                                          .isBefore(
                                              DateTime.parse(claseDateTime))) {
                                    return Dismissible(
                                      background: Container(
                                        color: Colors.red,
                                        padding: EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 32,
                                            height: 120,
                                            margin: EdgeInsets.only(right: 15),
                                            color: Color(0xFFf7aba3),
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Text("Cancelar",
                                                  style: TextStyle(
                                                      color: Color(0xFFda8c85),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                Text(
                                                    "${output.format(format.parse(state.list[index].hora_inicio))} - ${output.format(format.parse(state.list[index].hora_final))}",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "${state.list[index].fecha}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${state.list[index].nombre_gym}",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                    "${state.list[index].nombre_clase}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "Creditos: ${state.list[index].value}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blue,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "Status:  ${state.list[index].status}",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: (state
                                                                    .list[index]
                                                                    .status ==
                                                                "CANCELADA")
                                                            ? Colors.redAccent
                                                            : (state.list[index]
                                                                        .status ==
                                                                    "ACEPTADA")
                                                                ? Colors.greenAccent[
                                                                    100]
                                                                : Colors
                                                                    .blueGrey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                    "${state.list[index].number}",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.blueGrey,
                                                        decorationColor:
                                                            Colors.blue)),
                                                Text(
                                                  "",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      key: UniqueKey(),
                                      onDismissed: (direction) {
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
                                                    "No es posible cancelar 2 horas antes de la clase",
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
                                                              color: Color(
                                                                  0xff0781e5))),
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      }),
                                                ],
                                              );
                                            });
                                      },
                                    );
                                  } else {
                                    return Center(
                                        child: Container(
                                            child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              Text(
                                                  "${output.format(format.parse(state.list[index].hora_inicio))} - ${output.format(format.parse(state.list[index].hora_final))}",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                      decorationColor:
                                                          Colors.blue)),
                                              Text("${state.list[index].fecha}",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.blueGrey,
                                                      decorationColor:
                                                          Colors.blue)),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${state.list[index].nombre_gym}",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                  "${state.list[index].nombre_clase}",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.blueGrey,
                                                      decorationColor:
                                                          Colors.blue)),
                                              Text(
                                                  "Creditos: ${state.list[index].value}",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.blue,
                                                      decorationColor:
                                                          Colors.blue)),
                                              Text(
                                                  "Status:  ${state.list[index].status}",
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: (state.list[index]
                                                                  .status ==
                                                              "CANCELADA")
                                                          ? Colors.redAccent
                                                          : (state.list[index]
                                                                      .status ==
                                                                  "ACEPTADA")
                                                              ? Colors.greenAccent[
                                                                  100]
                                                              : Colors.blueGrey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decorationColor:
                                                          Colors.blue)),
                                              Text(
                                                  "${state.list[index].number}",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.blueGrey,
                                                      decorationColor:
                                                          Colors.blue)),
                                              Text(
                                                "",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )));
                                  }
                                } else {
                                  return Center(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Text(
                                                "${output.format(format.parse(state.list[index].hora_inicio))} - ${output.format(format.parse(state.list[index].hora_final))}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                    decorationColor:
                                                        Colors.blue)),
                                            Text("${state.list[index].fecha}",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.blueGrey,
                                                    decorationColor:
                                                        Colors.blue)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${state.list[index].nombre_gym}",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                                "${state.list[index].nombre_clase}",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.blueGrey,
                                                    decorationColor:
                                                        Colors.blue)),
                                            Text(
                                                "Creditos: ${state.list[index].value}",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.blue,
                                                    decorationColor:
                                                        Colors.blue)),
                                            Text(
                                                "Status:  ${state.list[index].status}",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: (state.list[index]
                                                                .status ==
                                                            "CANCELADA")
                                                        ? Colors.redAccent
                                                        : (state.list[index]
                                                                    .status ==
                                                                "ACEPTADA")
                                                            ? Colors.greenAccent[
                                                                100]
                                                            : Colors.blueGrey,
                                                    decorationColor:
                                                        Colors.blue)),
                                            Text("${state.list[index].number}",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.blueGrey,
                                                    decorationColor:
                                                        Colors.blue)),
                                            Text(
                                              "",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                                }
                              });
                        }

                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60.0,
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.blueAccent,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    /*BlocBuilder<ExternalControllerMisClasesCubit, int>(
              builder: (context, val) =>
                  val == 1 ? this.reservadas(context) : this.pasadas(context)
          )*/
                  ],
                )));
  }
}

class CustomTabSelector extends StatefulWidget {
  // final bool control;
  // CustomTabSelector({this.control});
  @override
  _CustomTabSelectorState createState() => new _CustomTabSelectorState();
}

class _CustomTabSelectorState extends State<CustomTabSelector> {
  Color def1 = _TabMisClasesState.tabdinamic == 1 ? Colors.white : Colors.blue;
  Color def1font =
      _TabMisClasesState.tabdinamic == 1 ? Colors.blue : Colors.white;
  Color def2 = _TabMisClasesState.tabdinamic == 1 ? Colors.blue : Colors.white;
  Color def2font =
      _TabMisClasesState.tabdinamic == 1 ? Colors.white : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        // used padding just for demo purpose to separate from the appbar and the main content
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.topCenter,
          child: Container(
              height: 38,
              padding: EdgeInsets.all(3.5),
              width: MediaQuery.of(context).size.width * 1.2,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(27)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: RaisedButton(
                        color: this.def1,
                        // height: double.infinity,
                        onPressed: () {
                          context
                              .read<ExternalControllerMisClasesCubit>()
                              .getClases(context.read<LoginCubit>().res['id']);
                          _TabMisClasesState.tabdinamic = 1;
                          setState(() {
                            this.def1 = Colors.white;
                            this.def1font = Colors.blue;
                            this.def2 = Colors.blue;
                            this.def2font = Colors.white;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(28.0),
                            side: BorderSide(color: Colors.blue)),
                        child: Container(
                          // margin: EdgeInsets.all(1),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: this.def1,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                  topLeft: Radius.circular(12))),
                          child: Text("Presentes",
                              style: TextStyle(
                                color: this.def1font,
                                fontSize: 17,
                              )),
                        )),
                  )),
                  Expanded(
                      child: RaisedButton(
                          color: this.def2,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(28.0),
                              side: BorderSide(color: Colors.blue)),
                          onPressed: () {
                            print('pasadas');
                            context
                                .read<ExternalControllerMisClasesCubit>()
                                .getClasesPasadas(
                                    context.read<LoginCubit>().res['id']);
                            _TabMisClasesState.tabdinamic = 2;
                            setState(() {
                              this.def1 = Colors.blue;
                              this.def1font = Colors.white;
                              this.def2 = Colors.white;
                              this.def2font = Colors.blue;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: this.def2,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    topRight: Radius.circular(12))),
                            child: Text("Pasadas",
                                style: TextStyle(
                                  color: this.def2font,
                                  fontSize: 17,
                                )),
                          ))),
                ],
              )),
        ));
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
      padding: EdgeInsets.only(top: 0),
      height: statusbarHeight + barHeight,
      child: Row(
        children: <Widget>[
          // IconButton(
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       size: 38,
          //       color: Colors.white,
          //     ),
          //     onPressed: null),
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
