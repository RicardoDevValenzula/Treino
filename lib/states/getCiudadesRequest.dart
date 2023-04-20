import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCiudadesRequest{
  
  Future<List<dynamic>> getCiudades() async{
    Uri route = Uri.parse('https://treino.club/demo/api/AppMovil/getAllCiudades');
    Map<String, String> headers = {'Content-Type': 'application/json'};

    http.Response response = await http.get(route, headers: headers);
    Map<String, dynamic> responseData = jsonDecode(response.body);

    return responseData['items'];
  }   

}