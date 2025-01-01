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
      body: Obx((){
        // if(users.isLoading.value){
        //   return const Center(child: CircularProgressIndicator(),);
        // }
        return Column(
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
                child:RefreshIndicator(
                  onRefresh: users.refreshData,
                  child: ListView.builder(
                    itemCount: users.users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide())),
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: Text(
                            DateFormat.yMEd().format(users.users[index].createdAt),
                            style: const TextStyle(fontSize: 14),
                          ),
                          title: Text(
                            users.users[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Text(
                            users.users[index].email,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    },
                  ),
                )
            )
          ],
        );
      }),
    );
  }
}

