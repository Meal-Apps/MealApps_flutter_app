
import 'package:mill_info/api/model_class/for_manager/search_user-model.dart';
import 'package:http/http.dart' as http;
import '../../../core/shared_value.dart';

class UserSearch{
  Future<SearchUser> getSearchUser(name)async{
    final response = await http.get(Uri.parse('https://mealapi.devrefat.com/api/usersearch/$name'),
        headers: {
          'Authorization': 'Bearer ${await getToken()}'
        }
    );

    if (response.statusCode == 200) {
      var data = searchUserFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}