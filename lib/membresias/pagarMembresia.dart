import 'package:credit_card_number_validator/credit_card_number_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:treino/membresias/result.dart';
import 'package:treino/notifications/provider/notification_provider.dart';
import 'package:treino/states/buyMembresias.dart';
import 'package:treino/stripe/wrapper.dart';
import 'package:flutter/foundation.dart' as Foundation;


enum SingingCharacter { lafayette, jefferson }


class PagarMembresia extends StatefulWidget {
  @override
  _PagarMembresiaState createState() => _PagarMembresiaState();
}

class _PagarMembresiaState extends State<PagarMembresia> {
  TextEditingController _nombreTitular = TextEditingController();
  TextEditingController _numeroTarjeta  = TextEditingController();
  TextEditingController _numeroSeguridad  = TextEditingController();
  TextEditingController _codigoPostal  = TextEditingController();
  TextEditingController _codigoPromo  = TextEditingController();

  TextEditingController _mesDeExpiracion  = TextEditingController();
  TextEditingController _anoDeExpiracion  = TextEditingController();


  TextEditingController _telefono = TextEditingController();
  String _datePickerLabel = "Fecha de expiracion";
  DateTime selectedDate = DateTime.now();
  int _selectedRadio = 0;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: GradientAppBar(""), preferredSize: Size.fromHeight(70)),
      body: SingleChildScrollView(
        child: Container(
           padding: const EdgeInsets.all(30),
           child: Form(
             key: _formKey,
             child: Column(
              children: [
                Container(
                  height: 32,
                  child: Center(
                    child: Text("Datos de cuenta",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue
                      ),
                    )
                  ),
                ),
                Container(
                  height: 50,
                  child: Center(
                    child: TextFormField(
                      controller: this._nombreTitular,
                      decoration: InputDecoration(hintText: "Nombre del titular"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'El campo no puede estar vacio';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Center(
                    child: TextFormField(
                      controller: this._numeroTarjeta,
                      decoration: InputDecoration(hintText: "Número de tarjeta"),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      validator: (value) {
                        Map<String, dynamic> cardData = CreditCardValidator.getCard(value);
                        if(!cardData[CreditCardValidator.isValidCard])
                          return 'Por favor ocupa un numero valido de tarjeta';
                        if (value.isEmpty) {
                          return 'El campo no puede estar vacio';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(right: 20),
                          height: 50,
                          child: Center(
                            child: TextFormField(
                              controller: this._mesDeExpiracion,
                              decoration: InputDecoration(hintText: "Mes de expiracion"),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'El campo no puede estar vacio';
                                }
                                return null;
                              },
                            ),
                          ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          height: 50,
                          child: Center(
                            child: TextFormField(
                              controller: this._anoDeExpiracion,
                              decoration: InputDecoration(hintText: "Año de expiracion"),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                              ],
                              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'El campo no puede estar vacio';
                                }
                                return null;
                              },
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
                ),
                  Container(
                  height: 50,
                  child: Center(
                    child: TextFormField(
                      controller: this._numeroSeguridad,
                      decoration: InputDecoration(hintText: "Número de seguridad"),
                      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'El campo no puede estar vacio';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(right: 20),
                          height: 50,
                          child: Center(
                            child: TextFormField(
                              controller: this._codigoPostal,
                              decoration: InputDecoration(hintText: "Codigo postal"),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                              ],
                              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'El campo no puede estar vacio';
                                }
                                return null;
                              },
                            ),
                          ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          height: 50,
                          child: Center(
                            child: TextFormField(
                              controller: this._telefono,
                              decoration: InputDecoration(hintText: "Telefono"),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              ],
                              obscureText: false,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'El campo no puede estar vacio';
                                }
                                return null;
                              },
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
                ),
                Container(
                  height: 50,
                  child: Center(
                    child: TextFormField(
                      controller: this._codigoPromo,
                      decoration: InputDecoration(hintText: "Codigo Promocional"),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  child: Radio(
                    value: this._selectedRadio,
                    groupValue: 1,
                    activeColor: Color(0xbf0781e5),
                    onChanged: (value) {
                      setState(() {
                        this._selectedRadio = (this._selectedRadio == 1) ? 0 : 0;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                  children: [
                      Container(
                        width: 200,
                        child: RaisedButton(
                            child: Text(
                              "Obtener membresia",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(28.0),
                                side: BorderSide(color: Color(0xbf0781e5))),
                            color: Color(0xbf0781e5),
                            onPressed: () async {
                              if(!_formKey.currentState.validate() || this.isLoading) return;

                              setState(() {
                                this.isLoading = true;
                              });

                              StripeWrapper sw = StripeWrapper(prod: Foundation.kReleaseMode);
                              ComprarMembresiasCubit cmc = context.read<ComprarMembresiasCubit>();

                                Token pm = await sw.createCard(
                                  number: this._numeroTarjeta.text,
                                  cvc: this._numeroSeguridad.text,
                                  month: int.parse(this._mesDeExpiracion.text),
                                  year: int.parse(this._anoDeExpiracion.text)
                                );

                                dynamic dobj = await sw.buyMembershipWithCard(clientId: cmc.idCliente, membershipId: cmc.idMembresiaSelected, token: pm.tokenId, codigoPromo: this._codigoPromo.text );
                                //print(dobj);
                                if(dobj["error"] != null){
                                  setState(() {
                                    this.isLoading = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => BuyResult(), settings: RouteSettings(arguments: dobj)),
                                  );
                                }else{
                                  this._notification(context, "Ha ocurrido un error inesperado");
                                }

                            }),
                      ),
                  ],
                )
                )
              ],
            ),
           ),
        )
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

  void comprarMembresia(
      {BuildContext context, String idMembresia, String idCliente}) async {
    // context.read<ComprarMembresiasCubit>().idMembresiaSelected = idMembresia;
    // context.read<ComprarMembresiasCubit>().idCliente = idCliente;
    await context.read<ComprarMembresiasCubit>().comprarMembresia(
        context.read<ComprarMembresiasCubit>().idCliente,
        context.read<ComprarMembresiasCubit>().idMembresiaSelected);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainMenu()),
    );
  }

    _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1960),
      lastDate: DateTime(selectedDate.year + 5),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _datePickerLabel = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        print(selectedDate.year);
      });
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
                  "Pagar",
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