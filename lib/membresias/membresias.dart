import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/loaders/minimal_loader.dart';
import 'package:treino/membresias/comprarMembresia.dart';
import 'package:treino/membresias/pagarMembresia.dart';
import 'package:treino/states/buyMembresias.dart';
import 'package:treino/states/membresias.dart';
import 'package:treino/states/payment.dart';
import 'package:treino/stripe/wrapper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:treino/notifications/provider/notification_provider.dart';

class Membresias extends StatefulWidget {
  @override
  _MembresiasState createState() => _MembresiasState();
}

class _MembresiasState extends State<Membresias> {
  double fontSize = 16;
  Color white = Colors.white;
  TextEditingController _codigoEmp  = TextEditingController();
  String  _notiCorrecto = "";
  Color _color_notificacion= Colors.red;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: GradientAppBar(""), preferredSize: Size.fromHeight(70)),
      body: SingleChildScrollView(
        child: Column(
          children: [

            BlocBuilder<MembresiasCubit, List<dynamic>>(
                builder: (context, val) => val != null
                    ? Column(
                        children: val
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(40.0),
                                          topRight: const Radius.circular(40.0),
                                          bottomLeft:
                                              const Radius.circular(40.0),
                                          bottomRight:
                                              const Radius.circular(40.0),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Text(e['nombre'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: white,
                                                  fontSize: this.fontSize)),
                                          Divider(
                                            color: white,
                                          ),
                                          Text(
                                            e['descripcion'],
                                            style: TextStyle(
                                                color: white,
                                                fontSize: this.fontSize),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            e['duracion'],
                                            style: TextStyle(
                                                color: white,
                                                fontSize: this.fontSize),
                                          ),
                                          Text(
                                            "Precio : " + e['precio'],
                                            style: TextStyle(
                                                color: white,
                                                fontSize: this.fontSize),
                                          ),
                                          Text(
                                            "Créditos: " + e['creditos'],
                                            style: TextStyle(
                                                color: white,
                                                fontSize: this.fontSize),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: RaisedButton(
                                                child: Text(
                                                  e['creditos'] + " creditos",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: this.fontSize),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(28.0),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.cyan[200])),
                                                color: Colors.cyan[200],
                                                onPressed: () async {
                                                  //actualiza id de membresia a comprar
                                                  await context
                                                      .read<
                                                          PayMembresiasCubit>()
                                                      .setIdMembresia(e['id']);

                                                  //actualiza id de membresia a comprar
                                                  await context
                                                      .read<
                                                          ComprarMembresiasCubit>()
                                                      .setIdMembresia(e['id']);
                                                  print(
                                                      "id membresia elegida " +
                                                          e['id']);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PagarMembresia(), settings: RouteSettings(arguments: false)),
                                                  );
                                                  print("probando");
                                                }),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: RaisedButton(
                                                child: Text(
                                                  "\$ " + e['precio'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: this.fontSize),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(28.0),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.lightGreen)),
                                                color: Colors.lightGreen,
                                                onPressed: () {
                                                  //actualiza id de membresia a comprar
                                                  context
                                                          .read<
                                                              ComprarMembresiasCubit>()
                                                          .idMembresiaSelected =
                                                      e['id'];
                                                  print(
                                                      "id membresia elegida " +
                                                          e['id']);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PagarMembresia(), settings: RouteSettings(arguments: false)),
                                                  );
                                                  print("probando");
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ))
                            .toList(),
                      )
                    : MinimalLoader()),
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(40.0),
                                  topRight: const Radius.circular(40.0),
                                  bottomLeft:
                                  const Radius.circular(40.0),
                                  bottomRight:
                                  const Radius.circular(40.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Text('Membresía Empresarial',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: white,
                                          fontSize: this.fontSize)),
                                  Divider(
                                    color: white,
                                  ),
                                  TextField(
                                      controller: this._codigoEmp,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(const Radius.circular(28.0),),
                                          borderSide: new BorderSide(color:  Colors.cyan[200], width: 5.0),),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(const Radius.circular(28.0),),
                                          borderSide: BorderSide(color:  Colors.cyan[200], width: 5.0),
                                        ),
                                        labelText: 'Introduzca codigo',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),

                                  this. _notiCorrecto != "" ?Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(this._notiCorrecto,
                                          style:
                                          TextStyle(color: this._color_notificacion, fontSize: this.fontSize)),
                                    ),
                                  ): Container(

                                  ),
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2.5,
                                    child: RaisedButton(
                                        child: Text(
                                          "Utilizar codigo",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: this.fontSize),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius
                                                .circular(28.0),
                                            side: BorderSide(
                                                color:
                                                Colors.lightGreen)),
                                        color: Colors.lightGreen,
                                        onPressed: () async {

                                          StripeWrapper sw = StripeWrapper(prod: Foundation.kReleaseMode);
                                          ComprarMembresiasCubit cmc = context.read<ComprarMembresiasCubit>();

                                            dynamic dobj = await sw.getPointsWithCode(idCliente: cmc.idCliente, codigo: this._codigoEmp.text);

                                            if(dobj["error"] == "0"){
                                              showDialog(context: context,
                                                  builder: (context){
                                                    return CupertinoAlertDialog(
                                                      title: Text("Aviso", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
                                                      content: Text(dobj["descripcion"], textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          child: Text("Aceptar", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                                                          onPressed: () => Navigator.pop(context),
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );
                                              setState(() {
                                                /*this._notiCorrecto=dobj["descripcion"];
                                                this._color_notificacion = Colors.lightGreen;
                                                return;*/
                                              });
                                            }else{
                                                // Fluttertoast.showToast(
                                                //     msg: dobj["descripcion"],
                                                //     toastLength: Toast.LENGTH_SHORT,
                                                //     textColor: Colors.black,
                                                //     fontSize: 16,
                                                //     backgroundColor: Colors.grey[200],
                                                // );
                                                this._notification(context, dobj["descripcion"]);
                                              return;
                                            }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cambiar o cancelar tu plan",
                    style:
                        TextStyle(color: Colors.blue, fontSize: this.fontSize)),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       // color: Colors.,
            //       borderRadius: BorderRadius.circular(20),
            //       // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20),
            //       child: Container(
            //         padding: EdgeInsets.all(20),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           border: Border.all(width: 3, color: Colors.blue),
            //         ),
            //         child: Column(
            //           children: [
            //             Text("Treino Pro".toUpperCase(),
            //                 style: TextStyle(
            //                     color: Colors.blue,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: this.fontSize)),
            //             Divider(),
            //             Text(
            //                 "Acceso limitado a clases en nuestra red de studios TREINO PLUS, hasta 4 visitas al mes por studio",
            //                 style: TextStyle(
            //                     color: Colors.blue, fontSize: this.fontSize)),
            //             Text("\$1,400",
            //                 style: TextStyle(
            //                     color: Colors.blue, fontSize: this.fontSize)),
            //             RaisedButton(
            //                 child: Text(
            //                   "Cambiar mi plan",
            //                   style: TextStyle(
            //                       color: Colors.white, fontSize: this.fontSize),
            //                 ),
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: new BorderRadius.circular(28.0),
            //                     side: BorderSide(color: Colors.lightGreen)),
            //                 color: Colors.lightGreen,
            //                 onPressed: () {
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => PagarMembresia()),
            //                   );
            //                   print("probando");
            //                 })
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                // color: Colors.blueAccent,
                width: 200,
                /*child: RaisedButton(
                    // minWidth: 100,
                    elevation: 2,
                    child: Text(
                      "Cancelar mi plan",
                      style: TextStyle(
                          fontSize: this.fontSize, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(28.0),
                        side: BorderSide(color: Color(0xbf0781e5))),
                    color: Colors.blueAccent, // Color(0xbf0781e5),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenu()),
                      );
                      print("probando");
                    }),*/
              ),
            ),
          ],
        ),
      ),
    );
  }
   void _notification(BuildContext ctx, String message) {
    NotificationCubit nc = context.read<NotificationCubit>();
    showDialog(context: nc.appContext,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text("Aviso", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
            content: Text(message, textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
            actions: [
              CupertinoDialogAction(
                child: Text("Aceptar", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff0781e5))),
                onPressed:  () => Navigator.pop(context),
              )
            ],
          );
        }
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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: null),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Membresías",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
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
