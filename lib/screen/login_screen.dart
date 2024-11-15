import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:mill_info/api/endpoints.dart';
import 'package:mill_info/api/services/login-service.dart';
import 'package:mill_info/core/data-load-from-api.dart';
import 'package:mill_info/core/shared_value.dart';
import 'package:mill_info/main.dart';
import 'package:mill_info/screen/singup_screen.dart';
import 'home_screen.dart';


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
      body: Padding(
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
                decoration: InputDecoration(
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
                        await LoginApiService().login(_emailController.text, _passwordController.text, endpoint: userLogin).then(
                                (value){
                              token.$=value['access_token'];
                              isManager.$= false;
                              isManager.load();
                              token.load();
                              print("this is token : ${token.$}");
                              Fluttertoast.showToast( msg:"Login successfully");
                              print(" msg ${value['name']}");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()),  (Route<dynamic> route) => false);
                            }).catchError((e){
                              print(e);
                          Fluttertoast.showToast( msg:"error:  $e");
                        });
                        print("isclicked");
                      }
                    },
                    child: const Text('Login as user'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await LoginApiService().login(_emailController.text, _passwordController.text, endpoint: managerLogin).then(
                                (value){
                              token.$=value['access_token'];
                              isManager.$=true;
                              isManager.load();
                              token.load();
                              print("this is token : ${token.$}");
                              Fluttertoast.showToast( msg:"${value['message']}");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()),  (Route<dynamic> route) => false);
                            }).catchError((e){
                          Fluttertoast.showToast( msg:"error: $e");
                        });
                        print("isclicked");
                      }
                    },
                    child: const Text('Login as manager'),
                  ),
                ],
              )
             ,

              // Switch between login and signup modes
              TextButton(
                onPressed: () {
                  setState(() {
                    // _isLoginMode = !_isLoginMode;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  });
                },
                child: const Text('Create Manager'),
              )

              // ... other form fields as needed
            ],
          ),
        ),
      ),
    );
  }

  // ... other form fields and logic
}
