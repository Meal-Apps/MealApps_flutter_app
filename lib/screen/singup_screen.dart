import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mill_info/api/services/for_manager/registration.dart';
import 'package:mill_info/screen/login_screen.dart';

import '../core/utils/email_validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mealNameController=TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Create Manager",style: TextStyle(fontSize: 18,height: 10),),
                // Name field
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10,),



                // Email field
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if(!validateEmail(value)){
                      return 'Please enter validate email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10,),



                // meal name field
                TextFormField(
                  controller: _mealNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Meal name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Meal Name',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10,),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10,),

                // Signup button
                isLoading?const CircularProgressIndicator():ElevatedButton(
                  onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        isLoading =true;
                        setState(() {});
                        var user = RegApiService().registration(_emailController.text, _passwordController.text, _nameController.text, _mealNameController.text);
                        user.then((onValue){
                          isLoading=false;
                          setState(() {
                          });
                          if(onValue['message']=="success"){
                            Fluttertoast.showToast(msg: onValue[ 'message'].toString());
                            Get.offAll(()=>  LoginSignupScreen(email: onValue['manager']['email'],));
                          }else{
                            isLoading=false;
                            setState(() {});
                            onValue['message'].forEach((key, value) {
                              Fluttertoast.showToast(msg: "$key : ${value[0]}");
                            });
                          }
                        });

                      }
                  },
                  child: const Text('Signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}
