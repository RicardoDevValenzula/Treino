abstract class RecoverPassState {}

class InitialState extends RecoverPassState{}

class RecoverPassLoading extends RecoverPassState {}

class RecoverPassSuccess extends RecoverPassState {}

class RecoverPassError extends RecoverPassState {
  final String _error;

  RecoverPassError(this._error);

  String get error => this._error;
} 

class RecoverPassRequestError extends RecoverPassState{}