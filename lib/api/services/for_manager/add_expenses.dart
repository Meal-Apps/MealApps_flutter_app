import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mill_info/api/endpoints.dart';

import '../../../core/shared_value.dart';

class AddExpensesApiService {
  Future<Map<String,dynamic>> expenses(
      {required String balance, required String des, required String date}) async {
    try{
      const url = 'https://mealapi.devrefat.com/api/$addExpenses'; // Replace with your API URL
      final response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.$}'

      }, body: jsonEncode(
          {
            "amount": balance,
            "description": des,
            "date": date
          }
      ));
      return jsonDecode(response.body);
    }catch(e){
      if(e is FormatException){
        return {'error':e.toString()};
      }
      return{'error':"Unknown Error"};
    }

  }
}