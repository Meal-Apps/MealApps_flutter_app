import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mill_info/core/utilis/controler.dart';
import 'package:mill_info/core/utilis/screen_size.dart';
import 'package:mill_info/screen/balance_screen.dart';
import 'package:mill_info/screen/input_screen.dart';
import 'package:mill_info/screen/login_screen.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/screen/manager-screen.dart';
import 'package:mill_info/screen/member-screen.dart';
import 'package:mill_info/screen/previous-month-expenses-screen.dart';
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
    print(AllDataController.managerAllInfo?.expenses.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Our Mill"),
        centerTitle: true,
        // leading: const Text(""),
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BalanceScreen())),
              child: const Text("Balance")),
          if (userCategory.$ == "millManager")
            IconButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddData()),
                    ),
                icon: const Icon(Icons.add))
        ],
      ),
      drawer: NavigationDrawer(
        children: [
          //user
          TextButton.icon(
            onPressed: () {
              userId.$ = "";
              userId.load();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MemberScreen()),);
            },
            label: const Text(
              "Members",
              style: TextStyle(fontSize: 17),
            ),
            icon: const Icon(
              Icons.people_alt_rounded,
              size: 20,
            ),
          ),
          //manager
          TextButton.icon(
            onPressed: () {
              userId.$ = "";
              userId.load();

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManagerScreen()),);
            },
            label: const Text(
              "Manager",
              style: TextStyle(fontSize: 17),
            ),
            icon: const Icon(
              Icons.people_alt_rounded,
              size: 20,
            ),
          ),
          // previous month expenses
          TextButton.icon(
            onPressed: () {
              userId.$ = "";
              userId.load();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PreviousMonthExpensesScreen()));
            },
            label: const Text(
              "Previous Month Expenses",
              style: TextStyle(fontSize: 17),
            ),
            icon: const Icon(
              Icons.sell,
              size: 20,
            ),
          ),
          //logout
          TextButton.icon(
            onPressed: () {
              userId.$ = "";
              userId.load();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginSignupScreen()),
                      (Route route) => false);
            },
            label: const Text(
              "Logout",
              style: TextStyle(fontSize: 17),
            ),
            icon: const Icon(
              Icons.logout_outlined,
              size: 20,
            ),
          )
        ],
      ),
      body:getExpenses(context, AllDataController.managerAllInfo!.expenses),
      bottomSheet: Container(
        color: Colors.lightGreenAccent,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: getTotalExpensesAndBalance(context, AllDataController.managerAllInfo),
      ),
    );
  }

}
