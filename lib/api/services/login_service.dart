import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApiService {
  Future<Map<String, dynamic>> login(String email, String password, {required String endpoint}) async {
    final url = 'https://mealapi.devrefat.com/api/$endpoint'; // Replace with your API URL
    final response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({'email': email, 'password': password}));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}