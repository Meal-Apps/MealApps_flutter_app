import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_value/shared_value.dart';

Future<String?> getToken() {
  return SharedPreferences.getInstance().then((prefs) {
    return prefs.getString('token');
  });
}

Future<bool> getIsManager() {
  return SharedPreferences.getInstance().then((prefs) {
    return prefs.getBool('isManager')??false;
  });
}



