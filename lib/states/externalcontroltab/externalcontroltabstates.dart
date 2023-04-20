import 'package:treino/states/solicitarfactura/solicitarfacturastate.dart';

import './result.dart';

abstract class ExternalControllTabState {
  List get list;
}

class InitState extends ExternalControllTabState {
  
  @override
  // TODO: implement list
  List get list => throw UnimplementedError();
}

class RequestState extends  ExternalControllTabState {
  
  String _type;

  RequestState(this._type);
  
  String get type => this._type;

  @override
  // TODO: implement list
  List get list => throw UnimplementedError();

}

class Loading extends ExternalControllTabState {
  @override
  // TODO: implement list
  List get list => throw UnimplementedError();
}


class Success extends ExternalControllTabState {
  List<Result> _list;
  
  Success(this._list);
  
  @override
  // TODO: implement list
  List get list => this._list;


}

