import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../core/utils/controller.dart';
import '../core/utils/screen_size.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});
  final users = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Members"),
      ),
      body: Obx(() {
        return Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Date",
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
              child: RefreshIndicator(
                  onRefresh: users.refreshData,
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2,
                    ),
                    itemCount: users.users.length * 3, // 3 fields per row
                    itemBuilder: (context, index) {
                      final item = users.users[index ~/ 3]; // Divide index by 3 to get the row
                      String fieldValue;
                      switch (index % 3) {
                        case 0:
                          fieldValue = DateFormat.yMEd().format(item.createdAt);
                          break;
                        case 1:
                          fieldValue = item.name;
                          break;
                        case 2:
                          fieldValue = item.email;
                          break;
                        default:
                          fieldValue = '';
                      }
                      return Center(child: Text(fieldValue));
                    },
                  )
              )),
        ]);
      }),
    );
  }
}