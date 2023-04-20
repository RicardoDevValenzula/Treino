import 'package:flutter/material.dart';
import 'package:treino/solicita_factura/exito.dart';
import 'package:treino/states/solicitarfactura/solicitarfactura.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/solicitarfactura/solicitarfacturastate.dart';

class SolicitaFactura extends StatefulWidget {
  @override
  _SolicitaFacturaState createState() => _SolicitaFacturaState();
}

class _SolicitaFacturaState extends State<SolicitaFactura> {
  
  TextEditingController email = TextEditingController();
  TextEditingController razonSocial = TextEditingController();
  TextEditingController rfc = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  TextEditingController colonia = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController cp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) =>
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                 decoration: BoxDecoration(
                   gradient: LinearGradient(
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                     stops: [0.2, 0.8],
                     colors: [Colors.greenAccent, Colors.blueAccent]
                   )
                 ),
                 child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment(-1,0.2),
                          child: BackButton(
                            color: Colors.white,
                          ),
                        ) 
                      ),
                      Expanded(
                        flex: 4, 
                        child: BlocConsumer<SolicitarFacturaCubit, SolicitarFacturaState>(
                          listener: (context, state){
                            if(state is SolicitarFacturaError) {
                              _notification(context, "Error!. " + state.error);
                              return;
                            }

                            if(state is SolicitarFacturaRequestError){
                              _notification(context, 'Error de conexion!. Inténtalo mas tarde');
                              return;
                            }

                            if(state is SolicitarFacturaSuccess){
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ExitoFactura()),
                                // MaterialPageRoute(builder: (context) => Membresias()),
                                );
                              return;
                            }
                          },
                          builder: (context, state) {
                            if(state is SolicitarFacturaLoading) {
                                return Container(
                                    alignment: Alignment(0.8,0.2),
                                    child: Container(
                                        height: 60.0,
                                        padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.blueAccent,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                    ),
                                  );
                            }
                            

                               return  Container(
                                  alignment: Alignment(0.8,0.2),
                                  child:  
                               GestureDetector(
                                      onTap: () {
                                        if(
                                          this.email.text == '' || this.razonSocial.text == '' || this.rfc.text == '' || 
                                          this.ciudad.text == '' || this.colonia.text == '' || this.direccion.text == '' ||
                                          this.cp.text == ''
                                      ){
                                        print(this.email.text);
                                        _notification(context, "Error!. Uno o mas campos de texto se encuentran vacios");
                                        return; 
                                      }

                                        context.read<SolicitarFacturaCubit>().facturaRequest(
                                          this.email.text, this.razonSocial.text, this.rfc.text,
                                          this.ciudad.text, this.colonia.text, this.direccion.text,
                                          this.cp.text
                                        );

                                      },
                                        child: Text(
                                          "Enviar",
                                          style: TextStyle( 
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white,
                                            decorationColor: Colors.blue,
                                          ),
                                        ),
                                      )
                               ); 
                          },
                        ),  
                     
                      ),
                  ],
                 )
                ),
              ),
               Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0, 30.0, 0),
                          alignment: Alignment(0,1),
                          child:  Text(
                            """Para solicitar tu factura del pago efectuado en el mes actual, por favor envíanos la siguiente información:
                          """),
                        ),  
                      ),
                    ],
                  ),
                ),
              ),
               Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 10),
                  alignment: Alignment(0,-1),
                  child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1,0),
                        child: TextFormField(
                          //controller: this.correoController,
                          controller: this.email,
                          decoration: InputDecoration(hintText: "Email Registrado"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ), 
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1,0),
                        child: TextFormField(
                          //controller: this.correoController,
                          controller: this.razonSocial,
                          decoration: InputDecoration(hintText: "Razon Social"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ),  
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1,0),
                        child: TextFormField(
                          //controller: this.correoController,
                          controller: this.rfc,
                          decoration: InputDecoration(hintText: "RFC"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ),   
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1,0),
                        child: TextFormField(
                          //controller: this.correoController,
                          controller: this.ciudad,
                          decoration: InputDecoration(hintText: "Ciudad"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ),   
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1,0),
                        child: TextFormField(
                          //controller: this.correoController,
                          controller: this.colonia,
                          decoration: InputDecoration(hintText: "Colonia"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ),   
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment(-1,0),
                        child:TextFormField(
                          //controller: this.correoController,
                          controller: this.direccion,
                          decoration: InputDecoration(hintText: "Direccion"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ),
                    ),
                    Expanded(
                      flex: 1, 
                      child:   Container(
                        alignment: Alignment(-1,0),
                        child:  TextFormField(
                          //controller: this.correoController,
                          keyboardType: TextInputType.number,
                          controller: this.cp,
                          decoration: InputDecoration(hintText: "CP"),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ), 
                      ),   
                    ),
                  ],
                ),
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }

   void _notification(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
