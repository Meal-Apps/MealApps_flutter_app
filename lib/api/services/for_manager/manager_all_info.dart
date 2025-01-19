
import 'package:mill_info/api/endpoints.dart';
import 'package:mill_info/api/model_class/for_manager/manager_all_info.dart';
import 'package:http/http.dart' as http;

import '../../../core/shared_value.dart';
class ApiData {
  Future<ManagerAllInfo> getManagerInfo() async {
    final response = await http.get(
        Uri.parse("https://mealapi.devrefat.com/api/$get_managers"),
        headers: {
          'Authorization': 'Bearer ${await getToken()}'
        }
    );
    // print(response.body);
    if (response.statusCode == 200) {
      var data = managerAllInfoFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
