 // @dart=2.9
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:treino/data/local_data.dart';
import 'package:treino/loading.dart';
import 'package:treino/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/notifications/firebase_notification_handler.dart';
import 'package:treino/notifications/notification_handler.dart';
import 'package:treino/notifications/provider/notification_provider.dart';
import 'package:treino/states/buyMembresias.dart';
import 'package:treino/states/categories.dart';
import 'package:treino/states/classDetail.dart';
import 'package:treino/states/classesPerGym.dart';
import 'package:treino/states/creditos/creditoscubit.dart';
import 'package:treino/states/detailGym.dart';
import 'package:treino/states/externalcontroltab/externalControlTab.dart';
import 'package:treino/states/getSolicitudes.dart';
import 'package:treino/states/getSolicitudesPasadas.dart';
import 'package:treino/states/get_categories_from_gym.dart';
import 'package:treino/states/gps_points.dart';
import 'package:treino/states/gym_coordinates.dart';
import 'package:treino/states/gymsPerCategory.dart';
import 'package:treino/states/membership/membresiacubit.dart';
import 'package:treino/states/payment.dart';
import 'package:treino/states/solicitarfactura/solicitarfactura.dart';
import 'package:treino/states/login/login.dart';
import 'package:treino/states/membresias.dart';
import 'package:treino/states/recoverpassword/recoverpass.dart';
import 'package:treino/states/register/register.dart';
import 'package:treino/states/agregarsolicitudclase/agregarSolicitudClase.dart';
import 'package:treino/states/tabperfil/tabperfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationHandler.initializeApp();
  NotificationHandler.initMessaging();
  runApp(TreinoApp());
  
}

class TreinoApp extends StatefulWidget {
  @override
  TreinoState createState() => TreinoState();
}

class TreinoState extends State<TreinoApp> {

  Future defaultViewFuture;
  NotificationHandler firebaseNotifications = new NotificationHandler();

  @override
  void initState() {
    
    setState(() {
      this.defaultViewFuture = this.getDefaultView();
    });
    super.initState();

    NotificationHandler.messageStream.listen((message) {
      print('MyApp: $message');
    });

  }

  Future<Widget> getDefaultView() async {
    dynamic user = await LocalData.db.queryUser();
    return user.length > 0 ? Loading() : FirstView();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider<MembresiasCubit>(
          create: (BuildContext context) => MembresiasCubit(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (BuildContext context) => CategoriesCubit(),
        ),
        BlocProvider<ClassDetailCubit>(
          create: (BuildContext context) => ClassDetailCubit(),
        ),
        BlocProvider<GymDetailCubit>(
          create: (BuildContext context) => GymDetailCubit(),
        ),
        BlocProvider<SolicitudesCubit>(
          create: (BuildContext context) => SolicitudesCubit(),
        ),
        BlocProvider<SolicitarFacturaCubit>(
          create: (BuildContext context) => SolicitarFacturaCubit(),
        ),
        BlocProvider<SolicitudesPasadasCubit>(
          create: (BuildContext context) => SolicitudesPasadasCubit(),
        ),
        BlocProvider<GymsPerCategoryCubit>(
          create: (BuildContext context) => GymsPerCategoryCubit(),
        ),
        BlocProvider<ComprarMembresiasCubit>(
          create: (BuildContext context) => ComprarMembresiasCubit(),
        ),
        BlocProvider<RecuperarPasswordCubit>(
          create: (BuildContext context) => RecuperarPasswordCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider<AgregarSolicitudCubit>(
          create: (BuildContext context) => AgregarSolicitudCubit(),
        ),
        BlocProvider<TabPerfilCubit>(
          create: (BuildContext context) => TabPerfilCubit(0),
        ),
        BlocProvider<CreditosCubit>(
          create: (BuildContext context) => CreditosCubit(),
        ),
        BlocProvider<MembresiaCubit>(
          create: (BuildContext context) => MembresiaCubit(),
        ),
        BlocProvider<ExternalControllerMisClasesCubit>(
          create: (BuildContext context) =>
              ExternalControllerMisClasesCubit(),
        ),
        BlocProvider<ClassesPerGymCubit>(
          create: (BuildContext context) => ClassesPerGymCubit(),
        ),
        BlocProvider<CoordinatesCubit>(
          create: (BuildContext context) => CoordinatesCubit(),
        ),
        BlocProvider<PayMembresiasCubit>(
          create: (BuildContext context) => PayMembresiasCubit(),
        ),
        BlocProvider<PointsCubit>(
          create: (BuildContext context) => PointsCubit(),
        ),
        //CategoriesFromGymCubit
        BlocProvider<CategoriesFromGymCubit>(
          create: (BuildContext context) => CategoriesFromGymCubit(),
        ),
        BlocProvider<NotificationCubit>(
          create: (BuildContext context) => NotificationCubit(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          FocusScopeNode currentFocus = FocusScope.of(context);            
          currentFocus.unfocus();
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: this.defaultViewFuture,
            builder: (context, data) { 
              if(data.hasData){
                return data.data;
              }
              return Scaffold(      
                body: Center(
                  child: Stack(
                    children: <Widget>[
                      Image(
                        fit: BoxFit.fitHeight,
                        height: MediaQuery.of(context).size.height,
                        image: AssetImage('assets/images/wallpaper.png')
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                          // height: 400,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.green],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: 1,
                          child: Image(
                            color: Colors.white,
                            colorBlendMode: BlendMode.srcIn,
                            fit: BoxFit.fitWidth,
                            height: 90,
                            width: 180,
                            image: AssetImage('assets/images/Group 2@2x.png')
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }

}

class FirstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {   
    return Scaffold(      
      body: Center(
        child: Stack(
          children: <Widget>[
            Image(
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.height,
              image: AssetImage('assets/images/wallpaper.png')
            ),
            Opacity(
              opacity: 0.7,
              child: Container(
                // height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.green],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: 1,
                child: Image(
                  color: Colors.white,
                  colorBlendMode: BlendMode.srcIn,
                  fit: BoxFit.fitWidth,
                  height: 90,
                  width: 180,
                  image: AssetImage('assets/images/Group 2@2x.png')
                ),
              ),
            ),
            Column(
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 350,
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                 
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      await Firebase.initializeApp();
      print("Handling a background message: ${message.messageId}");
      }

    