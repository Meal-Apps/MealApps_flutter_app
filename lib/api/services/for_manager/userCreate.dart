import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mill_info/api/endpoints.dart';

import '../../../core/shared_value.dart';

class UserCreateApiService {
  Future<Map<String,dynamic>> userCreate(String email, String password,String name) async {
    try{
      const url = 'https://mealapi.devrefat.com/api/$createUser'; // Replace with your API URL
      final response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await getToken()}'
      }, body: jsonEncode({
        'name':name,
        'email':email,
        'password':password
      }));
      return jsonDecode(response.body);
    }catch(e){
      if(e is FormatException){
        return {'error':e.toString()};

      }
      return{'error':"Unknown Error"};
    }

  }
}