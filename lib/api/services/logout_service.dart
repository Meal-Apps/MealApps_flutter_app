import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/shared_value.dart';

class LogoutApiService {
  Future<Map<String, dynamic>> logout({required String endpoint}) async {
    try{
      token.load();
      final url = 'https://mealapi.devrefat.com/api/$endpoint'; // Replace with your API URL
      final response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.$}',
      },);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("${response.statusCode}  body ${response.body}");
      }
    }catch(e){
      throw Exception("Logout Failed");
    }
  }
}