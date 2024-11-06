import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/utilis/controler.dart';
import '../core/utilis/screen_size.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Manager"),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Meal Name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "Name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "Email",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          //amount row
          SizedBox(
            height: screenHeight(context) * 0.8,
            child: ListTile(
              leading: Text(
                AllDataController.managerAllInfo!.manager.mealName,
                style: const TextStyle(fontSize: 14),
              ),
              title: Text(
                AllDataController.managerAllInfo!.manager.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Text(
                AllDataController.managerAllInfo!.manager.email,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
