class Result {
  String _id,_number, _value, _status, _hora_incio, _hora_final, _fecha, _nombre_gym, _nombre_clase, _onedaypass ;

  Result(this._id,this._number, this._value, this._status, this._hora_incio , this._hora_final, this._fecha, this._nombre_gym, this._nombre_clase, this._onedaypass, );

  String get id => this._id;

  String get number => this._number;

  String get value => this._value;

  String get status => this._status;

  String get hora_inicio => this._hora_incio;

  String get hora_final => this._hora_final;

  String get fecha => this._fecha;

  String get nombre_gym => this._nombre_gym;

  String get nombre_clase => this._nombre_clase;

  String get onedaypass => this._onedaypass;

}