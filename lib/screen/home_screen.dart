import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mill_info/core/utils/controller.dart';
import 'package:mill_info/screen/balance_screen.dart';
import 'package:mill_info/screen/input_screen.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/widget/drawer.dart' as drawer;
import 'package:mill_info/widget/expenses.dart';

class HomeScreen extends StatelessWidget  {
  HomeScreen({
    super.key,
  });
  final controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Our Mill"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BalanceView())),
              child: const Text("Balance")),
          FutureBuilder<bool>(future: getIsManager(),
              builder: (context,snapshot){
            if(snapshot.data==true){
              return   IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddData()),
                  ),
                  icon: const Icon(Icons.add));
            }else{
              return const SizedBox();
            }
              })
            
        ],
      ),
      drawer: drawer.Drawer().getDrawer(context),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        controller.expenses.sort((a,b)=>b.createdAt.compareTo(a.createdAt));

        return getExpenses(context, controller.expenses,controller.refreshData);
      }),
      bottomSheet: Container(
        color: Colors.lightGreenAccent,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Total Amount",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Expenses Amount",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Reserve Amount",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${controller.totalBalance} TK",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(" ${controller.totalExpenses}TK",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("${controller.currentBalance} TK",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
