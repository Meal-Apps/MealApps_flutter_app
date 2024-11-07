import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:shared_value/shared_value.dart';

final SharedValue<dynamic> millId = SharedValue(
  value: "", // initial value
  key: "millID", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);
final SharedValue<dynamic> isManager = SharedValue(
  value: false, // initial value
  key: "roll", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);
final SharedValue<dynamic> token = SharedValue(
    value: "",
    key: "token",
    autosave: true
);
