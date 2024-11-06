import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mill_info/core/utilis/balance-controller.dart';
import 'package:mill_info/core/utilis/controler.dart';
import 'package:mill_info/screen/home_screen.dart';
import 'package:shared_value/shared_value.dart';

// ...
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SharedValue.wrapApp( const MyApp()));
}
class Loading extends StatelessWidget{
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }

}
class MyApp extends StatelessWidget {
 const  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   var data = Get.put(AllDataController());
   var balance=Get.put(BalanceController());
   var expenses = Get.put(ExpensesController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx((){
        if(data.isLoading.value && balance.isLoading.value&&expenses.isLoading.value){
          return const Loading();
        }else{
          return const HomeScreen();
        }
      })

    );
  }

}

