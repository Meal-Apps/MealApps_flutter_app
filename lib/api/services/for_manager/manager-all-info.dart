
import 'package:mill_info/api/endpoints.dart';
import 'package:mill_info/api/model_class/for_manager/manager-all-info.dart';
import 'package:http/http.dart' as http;

import '../../../core/shared_value.dart';
class ApiData {
  Future<ManagerAllInfo> getManagerInfo() async {
    final response = await http.get(
        Uri.parse("https://mealapi.devrefat.com/api/$get_managers"),
        headers: {
          'Authorization': 'Bearer ${token.$}'
        }
    );
    if (response.statusCode == 200) {
      var data = managerAllInfoFromJson(response.body);
      return data;
      // final  data = jsonDecode(response.body);
      // return data.map((item) => ManagerAllInfo.fromJson(item)).toList();
    } else {
      print('Failed to load data');
      throw Exception("dfd");
    }
  }
}
