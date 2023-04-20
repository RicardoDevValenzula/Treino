import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/states/agregarsolicitudclase/agregarSolicitudClase.dart';
import 'package:treino/states/agregarsolicitudclase/agregarsolicitudclasestate.dart';

class ReservationNotification extends StatelessWidget {
  
  String _gym, _clase, _hora;
  
  ReservationNotification(this._gym, this._clase, this._hora);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.9, 0.0),
            stops: [0.0, 1],
            colors: [const Color(0xff13e860), Color(0xbf0781e5)],
          ),
        ),
         child: Center(
          child: Container(
            height: 400,
            width: 300,
            child: Card(
              child: Center(
                child: BlocBuilder<AgregarSolicitudCubit, AgregarSolicitudClaseState>(
                  builder: (context, state) {

                    if(state is Success) {
                
                      return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                                child: Text("¡Reservacion Confirmada!",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.blue,
                                  decorationColor: Colors.blue)
                                ),
                            ) 
                            
                          ), 
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment(0.0, 0.0),
                              child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment:  Alignment(0.0, 1),
                                    child: Text("${this._gym}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1, 
                                  child: Container(
                                    alignment: Alignment(0.0, 0.0),
                                    child: Text("${this._clase}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Text("${this._hora}"),
                                  ) 
                                )
                              ],
                            ),
                            ) 
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment(0.0, 0),
                              child: GestureDetector(
                                child: Text("Ver mas clases >"),
                                onTap: () {
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MainMenu()),
                                      // MaterialPageRoute(builder: (context) => Membresias()),
                                  );
                                },
                              ) 
                            ),
                          ),

                        ],
                      );

                    }

                      if(state is InitState) {
                
                      return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(Icons.sentiment_very_dissatisfied, color: Colors.blue, size: 40),
                                    ),
                                    Expanded(
                                      flex:  1,
                                      child:  Text("¡Lo sentimos!",
                                        style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.blue,
                                        decorationColor: Colors.blue)
                                      ),
                                    ),
                                  ],
                                )
                            ) 
                          ), 
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment(0.0, 0.0),
                              child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment:  Alignment(0.0, 0.0),
                                    child: Text("Los Lugares para: "),
                                  ),
                                ),
                                  Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment:  Alignment(0.0, 1),
                                    child: Text("${this._gym}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1, 
                                  child: Container(
                                    alignment: Alignment(0.0, 0.0),
                                    child: Text("${this._clase}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Text("${this._hora}"),
                                  ) 
                                )
                      
                              ],
                            ),
                            ) 
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment(0.0, 0),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment(0.0, 1),
                                            child: Text("Estan agotados.",
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ) 
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment(0.0, -1),
                                            child: Text("Intenta con otra clase.",
                                               style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ) 
                                          
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      child: Text("Ver mas clases >"),
                                      onTap: () {
                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => MainMenu()),
                                            // MaterialPageRoute(builder: (context) => Membresias()),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ), 
                            ),
                          ),

                        ],
                      );

                    }


                    return Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text("¡Reservacion Enviada!",
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.blue,
                              decorationColor: Colors.blue)
                            ),
                            ) 
                            
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text("Tu reservacion para: "),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              alignment: Alignment(0.0, -1.0),
                              child: Column(
                              children: [
                                   Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment:  Alignment(0.0, 1),
                                    child: Text("${this._gym}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1, 
                                  child: Container(
                                    alignment: Alignment(0.0, 0.0),
                                    child: Text("${this._clase}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Text("${this._hora}"),
                                  ) 
                                )
                              ],
                            ),
                            ) 
                            
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment(0.0, 1),
                              child: Column(
                                children: [
                                  Container(        
                                      padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.blueAccent,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                  Text("Esta siendo procesada."),
                                ],
                              ) 
                            ),
                          ),
                        ],
                      );

                  },
                ) 
                
                
             
              ),
          ),
          ) 
          
        ),
      ),
    );
  }

}