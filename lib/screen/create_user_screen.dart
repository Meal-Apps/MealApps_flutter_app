import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mill_info/api/services/for_manager/userCreate.dart';
import 'package:mill_info/screen/login_screen.dart';

class UserCreateScreen extends StatefulWidget {
  const UserCreateScreen({super.key});
  @override
  State<UserCreateScreen> createState() => _UserCreateScreen();
}

class _UserCreateScreen extends State<UserCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              const Text("Create User",style: TextStyle(fontSize: 18,height: 10),),
              // Name field
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter user name';
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
                    return 'Please enter user email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
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
                    return 'Please enter password';
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
                    var user = UserCreateApiService().userCreate(_emailController.text, _passwordController.text, _nameController.text);
                    user.then((onValue){
                      isLoading=false;
                      _emailController.clear();
                      _nameController.clear();
                      _passwordController.clear();
                      setState(() {
                      });
                        Fluttertoast.showToast(msg: "${onValue['message']}");
                    });

                  }
                },
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }}
