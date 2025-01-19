import 'package:flutter/material.dart';
import '../core/utils/controller.dart';
import '../core/utils/screen_size.dart';
import 'package:get/get.dart';

class ManagerScreen extends StatelessWidget {
   ManagerScreen({super.key});
   var manager = Get.put(ApiController()).manager;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Manager"),
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
            height: screenHeight(context) * 0.6,
            child: RefreshIndicator(
              onRefresh: ApiController().refreshData,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                Text(
                  manager!.mealName,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  manager!.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),softWrap: true,
                ),
               Text(
                  manager!.email,
                  style: const TextStyle(fontSize: 14),
                ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}
