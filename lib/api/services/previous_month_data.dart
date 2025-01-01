
import 'package:mill_info/api/model_class/for_user/balance_model.dart';
import 'package:mill_info/api/model_class/for_user/expanses-model.dart';
import '../../core/shared_value.dart';
import '../endpoints.dart';
import 'package:http/http.dart' as http;
Future<Balance> getPreviousBalance() async{
  final response  = await http.get(
      Uri.parse("https://mealapi.devrefat.com/api/$get_previous_balance"),
      headers: {
        'Authorization':'Bearer ${token.$}'
      }
  );
  if (response.statusCode == 200) {
    var data =balanceFromJson(response.body);
    return data;

  } else {
    throw Exception('Failed to load data');
  }
}
Future<PreviousMonthExpenses> getPreviousExpenses() async{
  final response  = await http.get(
      Uri.parse("https://mealapi.devrefat.com/api/$get_previous_expenses"),
      headers: {
        'Authorization':'Bearer ${token.$}'
      }
  );
  if (response.statusCode == 200) {
    var data =previousMonthExpensesFromJson(response.body);
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}
