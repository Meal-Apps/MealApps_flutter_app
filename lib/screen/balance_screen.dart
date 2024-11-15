import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/utils/controller.dart';


class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  bool isPreviousMonth = false;
  List<dynamic> balances = AllDataController.managerAllInfo!.balance;
  dynamic totalBalance = AllDataController.managerAllInfo!.totalBalance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("View Balance"),
        actions: [
          isPreviousMonth
              ? TextButton(
                  onPressed: () {
                    isPreviousMonth = false;
                    balances = AllDataController.managerAllInfo!.balance;
                    totalBalance = AllDataController.managerAllInfo!.totalBalance;
                    setState(() {});
                  },
                  child: const Text("Current month"))
              : TextButton(
                  onPressed: () {
                    isPreviousMonth = true;
                    balances = AllDataController.previousBalance!.balances;
                    totalBalance = AllDataController.previousBalance!.totalBalance;
                    setState(() {});
                  },
                  child: const Text("Previous month")),
        ],
      ),
      body: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.80,
          child: ListView.builder(
              itemCount: balances.length,
              itemBuilder: (context, index) {
                var balance = balances[index];
                return Container(
                  decoration:
                      const BoxDecoration(border: Border(bottom: BorderSide())),
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: Text(
                      DateFormat.yMEd().format(balance.createdAt),
                      style: const TextStyle(fontSize: 14),
                    ),
                    title: Text(
                      balance.userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      " ${balance.balance} TK",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              })),
      bottomSheet: Container(
        color: Colors.lightGreenAccent,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Total Amount",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("$totalBalance TK",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
