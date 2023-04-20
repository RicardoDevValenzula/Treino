import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treino/states/get_categories_from_gym.dart';

class PointPage extends StatefulWidget {
  final String idGym;
  PointPage({this.idGym});
  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("test"),
        ),
        body: BlocBuilder<CategoriesFromGymCubit, List<dynamic>>(
            builder: (context, val) => val != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[200],
                    child: Column(
                        // crossAxisCount: val.length,
                        children: val.map((e) => (Text(e['nombre']))).toList()))
                : Container()));
  }
}
