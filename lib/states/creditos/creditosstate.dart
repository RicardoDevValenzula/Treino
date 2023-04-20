import './results.dart';

abstract class CreditosState{
  List get list;
}

class InitState extends CreditosState{
  @override
  // TODO: implement list
  List get list => throw UnimplementedError();
}

class RequestState extends CreditosState {
  
  String _type;

  RequestState(this._type);
  
  String get type => this._type;

  @override
  // TODO: implement list
  List get list => throw UnimplementedError();

}


class Loading extends CreditosState {
  @override
  // TODO: implement list
  List get list => throw UnimplementedError();
}


class Success extends CreditosState {
  List<Result> _list;
  String _creditosTotales, _creditosGastados;
  
  Success(this._list, this._creditosTotales, this._creditosGastados);
  
  @override
  // TODO: implement list
  List get list => this._list;
  String get creditosTotales => this._creditosTotales;
  String get creditosGastos => this._creditosGastados;
}

class Error extends CreditosState {
  @override
  // TODO: implement list
  List get list => throw UnimplementedError();
}