import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mill_info/api/endpoints.dart';

class RegApiService {
  Future<Map<String,dynamic>> registration(String email, String password,String name,String mealName) async {
   try{
     const url = 'https://mealapi.devrefat.com/api/$regi'; // Replace with your API URL
     final response = await http.post(Uri.parse(url), headers: {
       'Content-Type': 'application/json',
     }, body: jsonEncode({
       'name':name,
       'email':email,
       'meal_name':mealName,
       'password':password
     }));
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