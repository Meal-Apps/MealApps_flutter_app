import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mill_info/api/endpoints.dart';

import '../../../core/shared_value.dart';

class AddBalanceApiService {
  Future<Map<String,dynamic>> balance(String balance,id) async {
    try{
      const url = 'https://mealapi.devrefat.com/api/$addBalance'; // Replace with your API URL
      final response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.$}'

      }, body: jsonEncode(
          {
            "balance" : balance,
            "user_id" :id
          }
      ));
      print(response.body);
      print(response.statusCode);

      return jsonDecode(response.body);
    }catch(e){
      if(e is FormatException){
        return {'error':e.toString()};

      }
      return{'error':"Unknown Error"};
    }

  }
}