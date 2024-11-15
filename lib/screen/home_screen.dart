import 'package:flutter/material.dart';
import 'package:mill_info/core/utils/controller.dart';
import 'package:mill_info/screen/balance_screen.dart';
import 'package:mill_info/screen/input_screen.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/widget/drawer.dart' as drawer;
import 'package:mill_info/widget/expenses.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Our Mill"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BalanceScreen())),
              child: const Text("Balance")),
          if (isManager.$)
            IconButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddData()),
                    ),
                icon: const Icon(Icons.add))
        ],
      ),
      drawer: drawer.Drawer.getDrawer(context),
      body:getExpenses(context, AllDataController.managerAllInfo?.expenses),
      bottomSheet:Container(
        color: Colors.lightGreenAccent,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Total Amount",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Expenses Amount",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Reserve Amount",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${AllDataController.managerAllInfo?.totalBalance} TK",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text(" ${AllDataController.managerAllInfo?.totalExpenses}TK",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text("${AllDataController.managerAllInfo?.currentBalance} TK",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
