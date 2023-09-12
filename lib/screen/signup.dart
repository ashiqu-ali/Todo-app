import 'package:flutter/material.dart';
import 'package:todoapp/screen/login.dart';
import 'package:todoapp/screen/signup.dart';
import 'package:todoapp/screen/todo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? _success;
  String? _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                SizedBox(height: 40,),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.man),
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_2_rounded),
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: 'password',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        _register();
                      }
                      await Navigator.push(context, MaterialPageRoute(builder: (context)=>Todo()));
                    },
                    child: Text('Register!', style: TextStyle(fontSize: 23),),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have an Account'),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                        child: Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final user = userCredential.user;

      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
      } else {
        setState(() {
          _success = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _success = false;
      });
    }
  }
}
