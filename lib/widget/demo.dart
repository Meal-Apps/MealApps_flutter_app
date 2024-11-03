import 'package:flutter/material.dart';
import 'package:mill_info/api/model_class/for_manager/manager-all-info.dart';
import 'package:mill_info/api/services/for_manager/manager-all-info.dart';

class Tem extends StatefulWidget {
  const Tem({super.key});

  @override
  State<Tem> createState() => _TemState();
}

class _TemState extends State<Tem> {
  @override


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: FutureBuilder<ManagerAllInfo>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("${snapshot.data?.currentBalance}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
