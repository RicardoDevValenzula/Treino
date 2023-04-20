abstract class SolicitarFacturaState {}

class InitialState extends SolicitarFacturaState{}

class SolicitarFacturaLoading extends SolicitarFacturaState{}

class SolicitarFacturaError extends SolicitarFacturaState {
  final String _error;

  SolicitarFacturaError(this._error);

  String get error =>  this._error;
}

class SolicitarFacturaSuccess extends SolicitarFacturaState{}

class SolicitarFacturaRequestError extends SolicitarFacturaState{}

