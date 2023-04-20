import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treino/data/LoginModel.dart';
import 'package:treino/data/local_data.dart';
import 'package:treino/notifications/provider/notification_provider.dart';
import 'package:treino/recover_password/recover_password.dart';
import 'package:treino/register/signup.dart';
import 'package:treino/Mainmenu/MainMenu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/agregarsolicitudclase/agregarSolicitudClase.dart';
import 'package:treino/states/buyMembresias.dart';
import 'package:treino/states/getSolicitudes.dart';
import 'package:treino/states/getSolicitudesPasadas.dart';
import 'package:treino/states/gps_points.dart';
import 'package:treino/states/login/login.dart';
import 'package:treino/states/login/loginstates.dart';
import 'package:treino/states/payment.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  // static final _mainMenuKey = new GlobalKey<_MainMenuState>();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NotificationCubit nc;
  // static final _mainMenuKey = new GlobalKey<_MainMenuState>();

  @override
  void initState() {
    nc = context.read<NotificationCubit>();
    nc.notificationHandler.init(nc);

    this.auto_login();

    super.initState();
  }

  void auto_login() async {
    
    dynamic users = await LocalData.db.queryUser(); 

    if(users.length > 0){
      print(users[0]);
      LoginModel lm = LoginModel.fromJson(users[0]);

      await context.read<LoginCubit>().loginInto(
        correo: lm.user,
        password: lm.pass
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 0.0, 38.0, 0.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment(0.0, 1.0),
                  child: Opacity(
                    opacity: 1,
                    child: Image(
                        // color: Colors.white,
                        // colorBlendMode: BlendMode.srcIn,
                        fit: BoxFit.fitWidth,
                        height: 90,
                        width: 180,
                        image: AssetImage('assets/images/Path 8@2x.png')),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment(-1, 1),
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment(0.0, 1.0),
                            child: TextFormField(
                              controller: this.correoController,
                              decoration: InputDecoration(
                                  hintText: "Correo electronico"),
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
                            child: Center(
                              child: TextFormField(
                                controller: this.passwordController,
                                decoration:
                                    InputDecoration(hintText: "Contraseña"),
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        // Add TextFormFields and RaisedButton here.
                      ])),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: MaterialButton(
                    child: Text("¿Olvidaste tu contraseña?"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecoverPasswordPage()),
                      );
                    },
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment(0.0, -1.0),
                  child: BlocConsumer<LoginCubit, LoginCubitState>(
                    listener: (context, state) async {
                      if (state is LoginCubitApiError) {
                        _notification(context, 'Error de inicio de sesion!. ' + state.error);
                        await LocalData.db.removeUser();
                        return;
                      }

                      if (state is LoginCubitRequestError) {
                        _notification(
                            context, 'Error de conexion!. Inténtalo mas tarde');
                        return;
                      }

                      if (state is LoginCubitSuccess) {
                        var model = LoginModel();
                        model.user = this.correoController.text;
                        model.pass = this.passwordController.text;
                        await LocalData.db.addUser(model);
                        this._success(context);
                        return;
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginCubitLoading || state is LoginCubitSuccess) {
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
                      }

                      return Container(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          alignment: Alignment(0.0, 0.0),
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                child: RaisedButton(
                                    child: Text(
                                      "Iniciar sesion",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(28.0),
                                        side: BorderSide(
                                            color: Color(0xff13e860))),
                                    color: Color(0xff13e860),
                                    onPressed: () async {
                                      /*if (this.correoController.text == '' ||
                                          this.passwordController.text == '') {
                                        _notification(context,
                                            'Error de inicio de sesion!. Uno o mas campos se encuentran vacios.');
                                        return;
                                      }*/

                                      await context
                                          .read<LoginCubit>()
                                          .loginInto(
                                              correo:
                                                  this.correoController.text,
                                              password:
                                                  this.passwordController.text);

                                    }),
                              ),
                              Container(
                                width: 200,
                                child: RaisedButton(
                                    child: Text(
                                      "Crear Cuenta",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(28.0),
                                        side: BorderSide(
                                            color: Color(0xbf0781e5))),
                                    color: Color(0xbf0781e5),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()),
                                      );
                                      print("probando");
                                    }),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _success(BuildContext context) async {
    bool rpta = false;
    print(context.read<LoginCubit>().res);
    //obtiene los clases/solicitudes presentes
    await context
        .read<SolicitudesCubit>()
        .getSolicitudes(context.read<LoginCubit>().res['id']);
    //agrega id cliente a cubit pago
    //extrae todos los puntos de la ciudad
    await context
        .read<PointsCubit>()
        .setCoordinates(context.read<LoginCubit>().res['idCiudad'], context);
    //extrae todos
    await context
        .read<PayMembresiasCubit>()
        .setIdCliente(context.read<LoginCubit>().res['id']);
    //id cliente en agregar solicitud
    await context
        .read<AgregarSolicitudCubit>()
        .setIdCliente(context.read<LoginCubit>().res['id']);

    //obtiene las clases pasadas
    await context
        .read<ComprarMembresiasCubit>()
        .setIdCliente(context.read<LoginCubit>().res['id']);
    print("id cliente >>> " + context.read<ComprarMembresiasCubit>().idCliente);
    //pide las clases/solicitudes pasadas
    // await context.read<sol>()
    

    bool firebaseUpdate = await nc.updateDeviceToken(userId: context.read<LoginCubit>().res['id']);
    nc.appContext = context;
    print("Firebase Update $firebaseUpdate");
    print(nc);
    await context.read<SolicitudesPasadasCubit>().getSolicitudesPasadas(context.read<LoginCubit>().res['id']);
    if (!rpta) {
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
        // MaterialPageRoute(builder: (context) => Membresias()),
      );
    }
  }

  void _notification(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
