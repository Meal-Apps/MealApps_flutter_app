import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  const Loading({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }

}
