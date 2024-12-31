import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mill_info/core/utils/controller.dart';
import '../core/utils/screen_size.dart';

Widget getExpenses(BuildContext context,expenses){
  if(expenses!=null){
    return RefreshIndicator(
      onRefresh: ApiController().refreshData,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Date",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "Details",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "Price",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          //amount row
          SizedBox(
              height: screenHeight(context) * 0.8,
              child:ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide())),
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: Text(
                        DateFormat.yMEd().format(expenses[index].date),
                        style: const TextStyle(fontSize: 14),
                      ),
                      title: Text(
                        expenses[index].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        " ${expenses[index].amount} TK",
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
  }else{
    return const Center(
      child: Text("Empty...."),
    );
  }

}