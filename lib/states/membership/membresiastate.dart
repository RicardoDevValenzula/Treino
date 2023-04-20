import 'package:treino/states/creditos/creditosstate.dart';

abstract class MembresiaState {} 

class InitState extends MembresiaState {}

class Success extends MembresiaState {
  String _name, _date;

  Success(this._name, this._date);

  String get name => this._name;
  String get date => this._date;
}