abstract class LoginCubitState {}

class InitialState extends LoginCubitState {}

class LoginCubitLoading extends LoginCubitState {}

class LoginCubitApiError extends LoginCubitState {
  final String _error;

  LoginCubitApiError(this._error);

  String get error =>  this._error;
  
}

class LoginCubitSuccess extends LoginCubitState{}

class LoginCubitRequestError extends LoginCubitState {}