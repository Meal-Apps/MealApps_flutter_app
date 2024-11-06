import 'package:flutter/material.dart';
import 'package:mill_info/core/utilis/controler.dart';
import 'package:mill_info/widget/expenses.dart';

class PreviousMonthExpensesScreen extends StatelessWidget {
  const PreviousMonthExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous month expenses"),
      ),
      body: getExpenses(context, ExpensesController.expenses!.expenses),
      bottomSheet: getTotalExpensesAndBalance(context, ExpensesController.expenses!),
    );
  }
}
