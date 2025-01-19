import 'package:flutter/material.dart';
import 'package:mill_info/core/utils/controller.dart';
import 'package:mill_info/widget/expenses.dart';
import 'package:get/get.dart';
class PreviousMonthExpensesScreen extends StatelessWidget {
   PreviousMonthExpensesScreen({super.key});
  var expenses =Get.put(PreviousMonthExpensesApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous month expenses"),
      ),
      body:Obx((){
        if(expenses.isLoading.value){
          return const Center(child: CircularProgressIndicator(),);
        }
        return getExpenses(context, expenses.expenses,expenses.refreshData);
      }),
      bottomSheet: Obx(()=> Container(
        color: Colors.lightGreenAccent,
        height: 62,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Expenses Amount ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

            Text(" ${expenses.totalExpenses}TK",
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ))

    );
  }

}

