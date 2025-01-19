import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mill_info/screen/home_screen.dart';
import 'package:mill_info/screen/login_screen.dart';
import 'package:shared_value/shared_value.dart';

import 'core/shared_value.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(await getToken()!=null){
    runApp(const MyApp());
  }else{
    runApp(LoginScreen());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,

        home:HomeScreen());
  }
}
