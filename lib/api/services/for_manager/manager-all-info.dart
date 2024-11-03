import 'dart:convert';

import 'package:mill_info/api/endpoints.dart';
import 'package:mill_info/api/model_class/for_manager/manager-all-info.dart';
import 'package:http/http.dart' as http;
// _getToken(){return;}
Future<ManagerAllInfo> fetchData() async{
  const token ="32|Crb2woaH0sDAKLdDmVMIQeNcHHpnxg1ph2g7uBpA5138633a";
  final response  = await http.get(
    Uri.parse("https://mealapi.devrefat.com/api/$get_managers"),
    headers: {
      'Authorization':'Bearer $token'
    }
  );
  if (response.statusCode == 200) {
    // var data = ;
    return managerAllInfoFromJson(response.body);
    // final  data = jsonDecode(response.body);
    // return data.map((item) => ManagerAllInfo.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}