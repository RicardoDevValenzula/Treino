// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:treino/main.dart';
import 'package:treino/states/buyMembresias.dart';
import 'package:treino/states/categories.dart';
import 'package:treino/states/detailGym.dart';
import 'package:treino/states/getSolicitudes.dart';
import 'package:treino/states/getSolicitudesPasadas.dart';
import 'package:treino/states/gymsPerCategory.dart';
import 'package:treino/states/login.dart' as login;
import 'package:treino/states/membresias.dart';
import 'package:treino/states/register.dart' as register;
import 'package:treino/states/agregarSolicitudClase.dart';

void main() async {
  login.LoginCubit de = login.LoginCubit();
  dynamic def = await de.loginInto(correo: "test@gmail.com", password: "Loto");
  print(def);
  await register.RegisterCubit().register(
      nombre: "tester",
      apelli: "testerada",
      password: "Loto",
      ciudad: "Mexico",
      fechaNac: "1990-10-12",
      correo: "test@gmail.com",
      genero: "Masculino",
      telefono: "1234566");

  await CategoriesCubit().getAllCategorias();

  await GymsPerCategoryCubit().getGymByCategoria("1");

  await GymDetailCubit().getGymById('2');

  await MembresiasCubit().getMembresias();

  await ComprarMembresiasCubit().comprarMembresia("123", "123");

  //"123", "123", "1", "2019-12-12"

  await AgregarSolicitudCubit().agregarSolicitud();

  await SolicitudesCubit().getSolicitudes("123");
  await SolicitudesPasadasCubit().getSolicitudesPasadas("123");

  // testWidgets('testando', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //   login.LoginCubit de = login.LoginCubit();
  //   await de.loginInto(correo: "lic.cristianhdz@gmail.com", password: "Legion7373");
  //   //print(def);
  //   // Verify thatour counter starts at 0.
  //   // expect(find.text('0'), findsOneWidget);
  //   // expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   // await tester.tap(find.byIcon(Icons.add));
  //   // await tester.pump();

  //   // Verify that our counter has incremented.
  //   // expect(find.text('0'), findsNothing);
  //   // expect(find.text('1'), findsOneWidget);
  // });
}
