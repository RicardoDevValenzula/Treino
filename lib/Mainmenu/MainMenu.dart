import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treino/TabBuscarClase/TabBuscarMap.dart';
import 'package:treino/TabInicio/TabInicio.dart';
import 'package:treino/TabMisClases/TabMisClases.dart';
import 'package:treino/TabPerfil/TabPerfil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/data/local_data.dart';
import 'package:treino/membresias/membresias.dart';
import 'package:treino/states/categories.dart';
import 'package:treino/states/login/login.dart';
import 'package:treino/states/membresias.dart';
import 'package:http/http.dart' as http;

class MainMenu extends StatefulWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  // GlobalKey<_MainMenuState> _mainMenuState;
  GlobalKey<_MainMenuState> _key = GlobalKey();

  LatLng baseCoords;

  TabController tabController;

   Future getUserCredits(String idCliente) async {
    dynamic djson;
    try{
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getCreditosGastados"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"idCliente": "$idCliente"})
      )).body);
      print("---------------------------------------------------------------------------------");
      print(idCliente);
      print(djson);
      print("---------------------------------------------------------------------------------");
    } catch (e) {
      print(e);
    }

    return djson;
  }

  @override
  void initState() {
    tabController = new TabController(length: 4, vsync: this);

    Future.delayed(Duration(milliseconds: 100), () async {
      if((await LocalData.db.queryPersistance()).isEmpty){
        await LocalData.db.registerPersistance();
        showDialog(
          context: context,
          builder: (context) => new CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: new Text('¡Bienvenido!', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: new Text('Adquiere nuestas membresias\ny empieza a disfrutar de\nTreino.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
            ),
            actions: <Widget>[
              new CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                textStyle: TextStyle(color: Colors.grey),
                child: new Text('Más Tarde'),
              ),
              new CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  await context.read<MembresiasCubit>().getMembresias();
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Membresias()));
                },
                child: new Text('Comprar'),
              ),
            ],
          ),
        );
        return;
      }
      
      dynamic credits = await this.getUserCredits(context.read<LoginCubit>().res["id"]);   

      if(credits["items"]["creditosTotales"] <= 0){
        showDialog(
          context: context,
          builder: (context) => new CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: new Text('¡Bienvenido!', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: new Text('¿Te quedaste sin créditos?\n¡Adquiere más!\nComprar / más tarde', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
            ),
            actions: <Widget>[
              new CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                textStyle: TextStyle(color: Colors.grey),
                child: new Text('Más Tarde'),
              ),
              new CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  await context.read<MembresiasCubit>().getMembresias();
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Membresias()));
                },
                child: new Text('Comprar'),
              ),
            ],
          ),
        );        
      }
    });

    Future.delayed(Duration.zero, () {
      dynamic args = ModalRoute.of(context).settings.arguments;
      if(LocalData.savedPos != null){
        tabController.animateTo(1);
      } else if(args["tab"] != null){
        tabController.animateTo(args["tab"]);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainMenu()),
    )) ?? false;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("No", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
          ),
          // SizedBox(height: 16),
          CupertinoDialogAction(
            onPressed: () => SystemNavigator.pop(),
            child: Text("Si", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
          )
        ],
        title: new Text('¿Seguro que desea cerrar sesión?', textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesCubit>().getAllCategorias();
    dynamic args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        GradientAppBar("Treino"),
                        Container(
                          color: Colors.white,
                          child: TabInicio(this.tabController)
                        )
                      ],
                    ),
                  ),
                ),
                TabBuscarMap(),
                TabMisClases(),
                TabPerfil(),
              ],
            ),
            bottomNavigationBar: Container(
              height: 60,
              color: Color(0xef0781e5),
              child: Center(
                child: TabBar(
                  controller: tabController,
                  onTap: (index) => tabController.animateTo(index),
                  tabs: [
                    Container(
                      child: Tab(
                        text: "Inicio",
                        icon: Container(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.home),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      text: "Buscar",
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.search)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      text: "Mis Clases",
                      icon: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.fitness_center)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      text: "Perfil",
                      icon: Container(
                        // height: 100,
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.person)
                          ],
                        ),
                      ),
                    )
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(0.0),
                  labelStyle: TextStyle(fontSize: 12),
                  indicatorColor: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 111.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Center(
        child: Center(
          child: Image(
            color: Colors.white,
            colorBlendMode: BlendMode.srcIn,
            fit: BoxFit.fitWidth,
            height: 60,
            width: 180,
            image: AssetImage('assets/images/Group 2@3x.png')
          ),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xff13e860), Color(0xbf0781e5)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.9, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        ),
      ),
    );
  }
}
