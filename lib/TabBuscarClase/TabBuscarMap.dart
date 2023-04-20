import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:treino/maps/gym_categories.dart';
import 'package:treino/data/local_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


class TabBuscarMap extends StatefulWidget {
  @override
  _TabBuscarMapState createState() => _TabBuscarMapState();
}

class _TabBuscarMapState extends State<TabBuscarMap> {

  var gradesRange = RangeValues(0, 5);
  LatLng currentPos = const LatLng(0, 0);

  Future<dynamic> gymList;
  GoogleMapController controller;

  @override
  void initState(){

    setState(() {
      this.gymList = getGymList();
    });

    super.initState();
  }

  @override
  void dispose(){
    if(this.controller != null) this.controller.dispose();
    super.dispose();
  }


  Future<dynamic> getGymList({String cityId, bool showers = false, bool lockers = false, bool valet = false, bool parking = false}) async {
    dynamic djson;

    try {
      dynamic body = {
        "idCiudad": cityId,
        "regaderas": showers ? 1 : 0,
        "lockers": lockers ? 1 : 0,
        "valet": valet ? 1 : 0,
        "parking": parking ? 1 : 0,
      };
      djson = json.decode((await http.post( Uri.parse("https://treino.club/demo/api/AppMovil/getGymsByFiltros") , body: json.encode(body))).body);
    } catch (e) {
      print(e);
    }
    return djson;
  }

  Future<void> _openGoogleMaps (double latitude, double longitude) async{
    String googleUrl = 'https://www.google.com/maps/place/$latitude,$longitude';
      await launch(googleUrl);
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.location]);

    try {
      setState(() {
        this.controller = controller;
      });            

      if(LocalData.savedPos != null) {
        controller.animateCamera(CameraUpdate.newLatLngZoom(LocalData.savedPos, 14)).catchError((_) => Future.value(false));
        LocalData.savedPos = null;
        return;
      }     
      Position position = await  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if(controller != null){
        controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 14)).catchError((_) => Future.value(false));
      }
    }catch(_){
      // Ignored
    }
  }

  Widget mapi() {
    return FutureBuilder(
    future: this.gymList,
      builder: (context, snap){
        if(snap.hasData){
          print("aun no truena");

          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: this.currentPos,
              zoom: 2,
            ),
            markers: snap.data["items"].map<Marker>(((gym) => Marker(
              markerId: MarkerId(gym["idGym"]),
              position: LatLng(double.parse(gym["latitud"]), double.parse(gym["longitud"])),
              infoWindow: InfoWindow(
                title: gym["nombre"],
                snippet: gym["informacion"],
                onTap: (){
                  //Aqui poner la redireccion a google maps con
                  _openGoogleMaps(double.parse(gym["latitud"]), double.parse(gym["longitud"]));
                },
              )
            ))).toList().toSet(),
          );
        }
        return MinimalLoader();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
      child: Scaffold(
        appBar: PreferredSize(child: GradientAppBar("Estudios Cerca"), preferredSize: new Size.fromHeight(80)
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: mapi()
        )
      )
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                minWidth: 6,
                onPressed: () {},
                child: Center(
                  child: Text(
                    this.title,
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
