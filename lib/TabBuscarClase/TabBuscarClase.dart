import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TabBuscarClase extends StatefulWidget {
  @override
  _TabBuscarClaseState createState() => _TabBuscarClaseState();
}

class _TabBuscarClaseState extends State<TabBuscarClase> {
  var gradesRange = RangeValues(0, 5);
  
  List<String> _ciudad, _distancia, _zona, _actividades;

  @override
  void initState(){
    super.initState();
    this._ciudad = List<String>();
    this._distancia = List<String>();
    this._zona = List<String>();
    this._actividades = List<String>();

    this._ciudad.add("Ciudad");
    this._distancia.add("Distancia");
    this._zona.add("Zona");
    this._actividades.add("Actividades");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: GradientAppBar("buscando"),
          ),
          Expanded(
            child: Container(
              // height: double.infinity,
              padding: const EdgeInsets.fromLTRB(38.0, 0.0, 38.0, 0.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      "UBICACION",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blue,
                          decorationColor: Colors.blue),
                    )),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          DropdownButton<String>(
                            isExpanded: true,
                            value: "Ciudad",
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,
                            elevation: 5,
                            style: TextStyle(fontSize: 17, color: Colors.black54),
                            underline: Container(
                              height: 0.7,
                              color: Colors.black54,
                            ),
                            onChanged: (String newValue){

                            },
                            items: this._ciudad.map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(right: 20, top: 10),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: "Distancia",
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 30,
                                    elevation: 5,
                                    style: TextStyle(fontSize: 17, color: Colors.black54),
                                    underline: Container(
                                      height: 0.7,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String newValue){

                                    },
                                    items: this._distancia.map<DropdownMenuItem<String>>((String value){
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: "Zona",
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 30,
                                    elevation: 5,
                                    style: TextStyle(fontSize: 17, color: Colors.black54),
                                    underline: Container(
                                      height: 0.7,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String newValue){

                                    },
                                    items: this._zona.map<DropdownMenuItem<String>>((String value){
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Add TextFormFields and RaisedButton here.
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                        child: Text(
                      "HORARIO",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blue,
                          decorationColor: Colors.blue),
                    )),
                  ),
                  RangeSlider(
                    min: 0,
                    max: 5,
                    divisions: 5,
                    labels: RangeLabels(
                        '${gradesRange.start}', '${gradesRange.end}'),
                    values: gradesRange,
                    onChanged: (RangeValues value) {
                      setState(() {
                        gradesRange = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                        child: Text(
                      "DETALLES DE CLASE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blue,
                          decorationColor: Colors.blue),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: "Actividades",
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 30,
                      elevation: 5,
                      style: TextStyle(fontSize: 17, color: Colors.black54),
                        underline: Container(
                          height: 0.7,
                          color: Colors.black54,
                                    ),
                          onChanged: (String newValue){

                          },
                          items: this._actividades.map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                          }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                        child: Text(
                      "SERVICIOS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.blue,
                          decorationColor: Colors.blue),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff13e860),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 50,
                                width: 50,
                                // color: Colors.lightGreen[300],
                                child: Center(
                                    child: Icon(Icons.battery_charging_full,
                                        color: Colors.white))
                                ),
                                Text("Regaderas", 
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decorationColor: Colors.blue
                                  ),
                                )
                              ],
                            ) 
                            
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff13e860),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 50,
                                width: 50,
                                // color: Colors.lightGreen[300],
                                child: Center(
                                    child: Icon(Icons.battery_charging_full,
                                        color: Colors.white))
                                ),
                                Text("Lockers", 
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decorationColor: Colors.blue
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff13e860),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 50,
                                width: 50,
                                // color: Colors.lightGreen[300],
                                child: Center(
                                    child: Icon(Icons.view_carousel,
                                        color: Colors.white))
                                ),
                                Text("Valet", 
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decorationColor: Colors.blue
                                  ),
                                )
                              ],
                            ) 
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff13e860),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 50,
                                width: 50,
                                // color: Colors.lightGreen[300],
                                child: Center(
                                    child: Icon(Icons.not_listed_location,
                                        color: Colors.white))
                                ),
                                Text("Parking", 
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decorationColor: Colors.blue
                                  ),
                                )
                              ],
                            )  
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
      height:barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                minWidth: 6,
                onPressed: () {
                },
                child: Center(
                  child: Text(
                    "Estudios Cerca",
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