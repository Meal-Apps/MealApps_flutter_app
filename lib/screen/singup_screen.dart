import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_info/api/services/for_manager/registration.dart';
import 'package:mill_info/screen/login_screen.dart';

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
      body: Padding(
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
                      isLoading =true;
                      setState(() {});
                      var user = RegApiService().registration(_emailController.text, _passwordController.text, _nameController.text, _mealNameController.text);
                      user.then((onValue){
                        isLoading=false;
                        setState(() {
                        });
                        if(onValue['message']=="success"){
                          Fluttertoast.showToast(msg: onValue[ 'message'].toString());
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginSignupScreen()), (route) => false);
                          if (kDebugMode) {
                            print("error not null : $onValue");
                          }
                        }else{
                          isLoading=false;
                          setState(() {});
                          onValue['message'].forEach((key, value) {
                            Fluttertoast.showToast(msg: "$key : ${value[0]}");
                          });
                          if (kDebugMode) {
                            print("error :  ${onValue['message']}");
                          }
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
    );
  }}
