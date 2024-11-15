import 'package:flutter/material.dart';
import 'package:mill_info/core/utils/controller.dart';
import 'package:mill_info/widget/expenses.dart';
class PreviousMonthExpensesScreen extends StatefulWidget {
  const PreviousMonthExpensesScreen({super.key});

  @override
  State<PreviousMonthExpensesScreen> createState() => _PreviousMonthExpensesScreenState();
}

class _PreviousMonthExpensesScreenState extends State<PreviousMonthExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous month expenses"),
      ),
      body:getExpenses(context, AllDataController.expenses?.expenses),
      bottomSheet: Container(
        color: Colors.lightGreenAccent,
        height: 62,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Expenses Amount ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

            Text(" ${AllDataController.expenses?.totalExpenses}TK",
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),

    );
  }
}


