import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mill_info/core/data-load-from-api.dart';
import 'package:mill_info/screen/home_screen.dart';
import 'package:shared_value/shared_value.dart';

import 'core/utils/controller.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SharedValue.wrapApp( const MyApp()));
}

class MyApp extends StatelessWidget {
 const  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:loadData(const HomeScreen())
    );
  }


}

