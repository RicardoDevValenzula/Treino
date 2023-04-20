import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/TabMisClases/TabMisClases.dart';
import 'package:treino/maps/category_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treino/TabBuscarClase/TabBuscarClasePrimer.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:treino/states/categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/externalcontroltab/externalControlTab.dart';
import 'package:treino/states/getSolicitudes.dart';
import 'package:treino/states/getSolicitudesPasadas.dart';
import 'package:treino/states/gymsPerCategory.dart';
import 'package:http/http.dart' as http;
import 'package:treino/states/login/login.dart';

class TabInicio extends StatefulWidget {
  final TabController tabCcontroller;
  TabInicio(this.tabCcontroller);
  @override
  _TabInicioState createState() => _TabInicioState();
}

class _TabInicioState extends State<TabInicio> {
  Future reservatedFtr;
  Future asistedFtr;

  @override
  void initState() {
    setState(() {
      var id = context.read<LoginCubit>().res["id"];
      this.reservatedFtr = this.getRequest(id, 'getSolicitudes');
      this.asistedFtr = this.getRequest(id, 'getSolicitudesPasadas');
    });
    super.initState();
  }

  Future getRequest(String idCliente, String endpoint) async {
    dynamic djson;
    try {
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/$endpoint")
              ,
              headers: {'Content-Type': 'application/json'},
              body: json.encode({"idCliente": "$idCliente"})))
          .body);
    } catch (e) {}

    return djson;
  }

  @override
  Widget build(BuildContext context) {
    var fixedWidth = (MediaQuery.of(context).size.width);

    return Container(
      width: fixedWidth,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(), settings: RouteSettings(arguments: {
                              "tab": 2,
                              "move": 1,
                            })));
                          },
                          child: 
                          Text("Reservadas", style:(TextStyle(fontSize: 14,color: Colors.white)) ),
                        ),
                      ],
                    ))),
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu(), settings: RouteSettings(arguments: {
                              "tab": 2,
                              "move": 2,
                            })));
                          },
                          child: 
                          Text("Historial", style:(TextStyle(fontSize: 14,color: Colors.white)) ),
                        ),
                      ],
                    ))),
              ],
            ),
            color: Colors.grey[400],
          ),
          Container(
            height: 20,
            color: Colors.white,
          ),
          BlocBuilder<CategoriesCubit, List<dynamic>>(
              builder: (context, val) => val != null
                  ? Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: val
                          .map((e) => FlatButton(
                              onPressed: () {
                                context
                                    .read<GymsPerCategoryCubit>()
                                    .setIdCategoria(e["id"]);
                                context.read<GymsPerCategoryCubit>().reset();
                                context
                                    .read<GymsPerCategoryCubit>()
                                    .getGymByCategoria(e['id']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GymClasses(),
                                      settings: RouteSettings(arguments: {
                                        "clienteId": context.read<LoginCubit>().res["id"],
                                        "categoryId": context
                                            .read<GymsPerCategoryCubit>()
                                            .idCategoriaSeleccionado
                                      })),
                                );
                              },
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minWidth: 50, minHeight: 50),
                                  child: Container(
                                    width: fixedWidth / 3,
                                    height: fixedWidth / 3,
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(e['imagen'])),
                                        shape: BoxShape.circle),
                                    child: Stack(
                                      children: <Widget>[
                                        Opacity(
                                          opacity: 0.5,
                                          child: Container(
                                              decoration: new BoxDecoration(
                                                  color: Color(0xef0763e5),
                                                  borderRadius: new BorderRadius
                                                          .all(
                                                      Radius.circular(100)))),
                                        ),
                                        Center(
                                          child: FittedBox(
                                              fit: BoxFit.cover,
                                              child: Text(e['nombre'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25))),
                                        ),
                                      ],
                                    ),
                                  ))))
                          .toList(),
                    )
                  : MinimalLoader()),
              Container(
                  child: FlatButton(
                      onPressed: () {
                        context
                            .read<GymsPerCategoryCubit>()
                            .setIdCategoria("0");
                        context.read<GymsPerCategoryCubit>().reset();
                        context
                            .read<GymsPerCategoryCubit>()
                            .getGymByCategoria("0");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GymClasses(),
                              settings: RouteSettings(arguments: {
                                "clienteId": context.read<LoginCubit>().res["id"],
                                "categoryId": context
                                    .read<GymsPerCategoryCubit>()
                                    .idCategoriaSeleccionado
                              })),
                        );
                      },
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: 50, minHeight: 50),
                          child: Container(
                            width: fixedWidth / 3,
                            height: fixedWidth / 3,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/circles/Intersection 8@3x.png")),
                                shape: BoxShape.circle),
                            child: Stack(
                              children: <Widget>[
                                Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                      decoration: new BoxDecoration(
                                          color: Color(0xef0763e5),
                                          borderRadius: new BorderRadius
                                              .all(
                                              Radius.circular(100)))),
                                ),
                                Center(
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text("General",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25))),
                                ),
                              ],
                            ),
                          )
                      )
                  )
              )
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=9',
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
