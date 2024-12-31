import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mill_info/core/data_load_from_api.dart';
import 'package:mill_info/screen/home_screen.dart';
import 'package:mill_info/screen/login_screen.dart';
import 'package:shared_value/shared_value.dart';

import 'core/shared_value.dart';
main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(SharedValue.wrapApp( const MyApp()));
}

class MyApp extends StatelessWidget {
 const  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    token.load();
    isManager.load();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:token.$ !=""? HomeScreen():const LoginSignupScreen()
    );
  }


}

