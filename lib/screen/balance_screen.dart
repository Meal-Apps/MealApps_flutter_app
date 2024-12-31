import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../core/utils/controller.dart';
class BalanceView extends StatelessWidget{
  ApiController apiController = Get.put(ApiController());
   PreviousMonthBalanceApiController controller =Get.put(PreviousMonthBalanceApiController());
  RxBool isPreviousMonth = false.obs;
  BalanceView({super.key});
  @override
  Widget build(BuildContext context) {
    List<dynamic> balances = apiController.balance;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("View Balance"),
        actions: [Obx((){
          return isPreviousMonth.value
              ? TextButton(
              onPressed: () {
                isPreviousMonth(false);
                balances = apiController.balance;
              },
              child: const Text("Current month"))
              : TextButton(
              onPressed: () {
                isPreviousMonth(true);
               balances = controller.balance;
              },
              child: const Text("Previous month"));
        })

        ],
      ),
      body:Obx((){
        if(isPreviousMonth.value?controller.isLoading.value:apiController.isLoading.value){
          return const Center( child: CircularProgressIndicator(),);
        }
          return RefreshIndicator(
            onRefresh: apiController.refreshData,
            child: ListView.builder(
                itemCount:balances.length,
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
                }),
          );}),
      bottomSheet: Obx(() {
        return Container(
        color:
        Colors.lightGreenAccent
        ,
        height: 60,
        padding: const EdgeInsets.all(10),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        const Text("Total Amount",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text("${isPreviousMonth.value?controller.totalBalance:apiController.totalBalance} TK",
        style:
        const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
        )
        ,
        );}),
    );
  }

}