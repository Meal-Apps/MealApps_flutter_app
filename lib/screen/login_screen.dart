import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mill_info/api/endpoints.dart';
import 'package:mill_info/api/services/login_service.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/screen/home_screen.dart';
import 'package:mill_info/screen/singup_screen.dart';

import '../core/utils/email_validation.dart';

class LoginSignupScreen extends StatefulWidget {
  String? email;
   LoginSignupScreen({super.key,this.email});
  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isULoading = false,isMLoading=false;

  @override
  Widget build(BuildContext context) {
    if(widget.email !=null){
      _emailController.text = widget.email!;
    }
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
                    isULoading? const CircularProgressIndicator() :  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                           isULoading = true ;
                           setState(() {});
                          FocusScope.of(context).unfocus();
                          await LoginApiService()
                              .login(_emailController.text,
                                  _passwordController.text,
                                  endpoint: userLogin)
                              .then((value) {
                            token.$ = value['access_token'];
                            isManager.$ = false;
                            isManager.load();
                            token.load();
                            isULoading = false ;
                            setState(() {});

                            Fluttertoast.showToast(msg: "Login successfully");
                            Get.offAll(() =>  HomeScreen());
                          }).catchError((e) {
                            isULoading = false ;
                            setState(() {});
                            Fluttertoast.showToast(msg: "error:  $e");
                          });
                        }
                      },
                      child: const Text('Login as user'),
                    ),
                    isMLoading? const CircularProgressIndicator() : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          isMLoading = true ;
                          setState(() {});
                          FocusScope.of(context).unfocus();
                          await LoginApiService()
                              .login(_emailController.text,
                                  _passwordController.text,
                                  endpoint: managerLogin)
                              .then((value) {
                            token.$ = value['access_token'];
                            isManager.$ = true;
                            isManager.load();
                            token.load();
                            isMLoading = false ;
                            setState(() {});
                            Fluttertoast.showToast(msg: "${value['message']}");
                            Get.offAll(() =>  HomeScreen());
                          }).catchError((e) {
                            isMLoading = false ;
                            setState(() {});
                            Fluttertoast.showToast(msg: "$e");
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
