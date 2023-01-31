import 'package:buscar_cep/models/cep_models.dart';
import 'package:http/http.dart' as http;

class CepReposiroty{
  Future<Cep?> buscaCep(String cep)async{
    String url =  "https://viacep.com.br/ws/$cep/json/";
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return Cep.fromJson(response.body);
      
    }


  }
}