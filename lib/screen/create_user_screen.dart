import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mill_info/api/services/for_manager/userCreate.dart';
import 'package:mill_info/core/utils/email_validation.dart';
import 'package:mill_info/screen/member_screen.dart';

import '../core/utils/controller.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create User",
                  style: TextStyle(fontSize: 18, height: 10),
                ),
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
                const SizedBox(
                  height: 10,
                ),
                // Email field
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter user email';
                    }
                    if (!validateEmail(value)) {
                      return 'Please enter validate email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                const SizedBox(
                  height: 10,
                ),

                // Signup button
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        isLoading = true;
                        setState(() {});
                        var user = UserCreateApiService().userCreate(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text);
                        user.then((onValue) {
                          isLoading = false;
                          if (onValue['success'] != null) {
                            String email =
                                onValue['message']['email']?[0] ?? "";
                            String password =
                                onValue['message']['password']?[0] ?? "";
                            Fluttertoast.showToast(msg: "$email $password");
                          } else {
                            Get.put(ApiController()).refreshData();
                            Get.offAll( MemberScreen());
                            _emailController.clear();
                            _nameController.clear();
                            _passwordController.clear();
                            Fluttertoast.showToast(
                                msg: "${onValue['message']}");
                          }
                          setState(() {});
                        });
                      }
                    },
                    child: const Text('Create User'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
