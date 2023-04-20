import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ExternalControllerMainTabsCubit extends Cubit<dynamic> {
  ExternalControllerMainTabsCubit() : super(null);
  // TabController tabber = TabController(length: 4);

  // void animate(int val) => emit(state.animateTo(val));
}

class ExternalControllerMisClasesCubit extends Cubit<int> {
  ExternalControllerMisClasesCubit() : super(1);

  void setVal(int val) => emit(val);
}
