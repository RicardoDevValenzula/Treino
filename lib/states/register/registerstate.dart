abstract class RegisterState {}

class InitialState extends RegisterState{}

class RegisterLoading extends RegisterState{}

class RegisterError extends RegisterState {
  final String _error;

  RegisterError(this._error);

  String get error => this._error;
}

class RegisterSuccess extends RegisterState {}

class RegisterRequestError extends RegisterState {}