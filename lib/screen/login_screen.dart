import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mill_info/api/endpoints.dart';
import 'package:mill_info/api/services/login_service.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/main.dart';
import 'package:mill_info/screen/singup_screen.dart';

import '../core/utils/email_validation.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});
  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login our MealApp",
                  style: TextStyle(fontSize: 17, height: 10),
                ),
                // Email field
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
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
                      return 'Please enter your password';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await LoginApiService()
                              .login(_emailController.text,
                                  _passwordController.text,
                                  endpoint: userLogin)
                              .then((value) {
                            token.$ = value['access_token'];
                            isManager.$ = false;
                            isManager.load();
                            token.load();
                            Fluttertoast.showToast(msg: "Login successfully");
                            Get.offAll(const MyApp());
                          }).catchError((e) {
                            Fluttertoast.showToast(msg: "error:  $e");
                          });
                        }
                      },
                      child: const Text('Login as user'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await LoginApiService()
                              .login(_emailController.text,
                                  _passwordController.text,
                                  endpoint: managerLogin)
                              .then((value) {
                            token.$ = value['access_token'];
                            isManager.$ = true;
                            isManager.load();
                            token.load();
                            // print("this is token : ${token.$}");
                            Fluttertoast.showToast(msg: "${value['message']}");
                            Get.offAll(() => const MyApp());
                          }).catchError((e) {
                            Fluttertoast.showToast(msg: "error: $e");
                          });
                        }
                      },
                      child: const Text('Login as manager'),
                    ),
                  ],
                ),

                // Switch between login and signup modes
                TextButton(
                  onPressed: () {
                    setState(() {
                      // _isLoginMode = !_isLoginMode;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    });
                  },
                  child: const Text('Create Manager'),
                )

                // ... other form fields as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ... other form fields and logic
}
