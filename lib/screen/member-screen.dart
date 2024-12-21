import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/utils/controller.dart';
import '../core/utils/screen_size.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Members"),
      ),
      body: Column(
        children: [
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
              child:ListView.builder(
                itemCount: AllDataController.managerAllInfo?.users.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide())),
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: Text(
                       "${ DateFormat.yMEd().format(AllDataController.managerAllInfo!.users[index].createdAt)}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      title: Text(
                        AllDataController.managerAllInfo!.users[index].name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                       AllDataController.managerAllInfo!.users[index].email,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              )
          )
        ],
      ),
    );
  }
}

