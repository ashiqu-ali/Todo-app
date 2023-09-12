import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screen/signup.dart';
import 'package:todoapp/screen/todo_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome Back',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 40,),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_2_rounded),
                  labelText: 'username',
                  border:OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 15,),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: 'password',
                  border:OutlineInputBorder(),
                  suffixIcon: Icon(Icons.remove_red_eye)
                ),
              ),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {

                },
                  child: Text('Forgot Password?'),

                ),
              ),
              FractionallySizedBox(
                widthFactor: 1.0,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Todo()));
                  },
                  child: Text('Login',style: TextStyle(fontSize: 23),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an Account?'),
                  // TextButton(onPressed: LogIn(),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                      child: Text('Signup'))
                ],

              )
            ],
          ),
        ),
      ),
    );
  }
}


