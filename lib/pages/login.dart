import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import '../widget/dialogBox.dart';
import 'home.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<dynamic> verifyData(email, password) async {
    try{
      final url = Uri.parse('https://bevel-ai.onrender.com/login_user/Bevel/');
      final response = await http.post(url,
          headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',},
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          })
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['statusCode'].toString();
      } else {
        // Handle the error accordingly
        return 'Failed to load data';
      }
    }
    catch(e){
      return 'Error Message: $e';
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 5),
          child:
          ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/splash.json',
                      width: 150,
                      height: 150,
                    ),
                    const Text('Sign in to your Ulo account',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,

                    ),)
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formkey,
                child:
                Column(
                  children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fields cannot be empty';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fields cannot be empty';
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: ()  async {
                    if (_formkey.currentState!.validate()){
                        showLottieDialog();
                        final result = await verifyData(emailController.text, passwordController.text);
                        if (result == '100') {
                          var box = Hive.box('settings');
                          box.put('hasSeenSplashScreen', true);
                          Get.off(()=> const Home());
                        }
                        else if(result == '404'){
                          Get.back();
                          Get.snackbar('Info', 'Incorrect Login Details.');
                        }
                        else{
                          Get.back();
                          Get.snackbar('Info', 'result');
                        }
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  ],
                ),
              ),
            ],
          )
      )
    );
  }
}

