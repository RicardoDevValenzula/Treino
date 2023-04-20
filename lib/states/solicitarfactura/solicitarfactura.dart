import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:treino/states/solicitarfactura/solicitarfacturastate.dart';

class SolicitarFacturaCubit extends Cubit<SolicitarFacturaState>{
  SolicitarFacturaCubit() : super(InitialState());

  Future<void> facturaRequest(
    String email, String razonSocial,
    String rfc, String ciudad,
    String colonia, String direccion,
    String cp
  ) async {
    emit(SolicitarFacturaLoading()); 
    try{
      final response = await http 
            .post( Uri.parse('https://treino.club/demo/api/AppMovil/facturacion') , 
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
          'email': email,
          'razonSocial': razonSocial,
          'rfc': rfc,
          'ciudad': ciudad,
          'colonia': colonia,
          'direccion': direccion,
          'cp': cp,
        })); 
        print(response.body);

        Map<String, dynamic> responseData = jsonDecode(response.body);
    
        if(responseData["error"] == '1'){
          emit(SolicitarFacturaError(responseData["descripcion"]));
          return;
        }

        emit(SolicitarFacturaSuccess());
    } on Exception {
      print("");
      emit(SolicitarFacturaRequestError());
    }
  }


}