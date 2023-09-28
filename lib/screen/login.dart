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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome Back',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(height: 40,),
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
                      print('onPressed');
                      _login();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Todo()));
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
      ),
    );
  }
  void _login() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('hello');
      final user = userCredential.user;
      if (user != null) {

          _success = true;
          _userEmail = user.email;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Todo()));
          _emailController.clear();
          _passwordController.clear();

      } else {

          _success = false;

      };
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Check E-mail ID/Password!"),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      // setState(() {
      //   _success = false;
      // }
    }catch(e){
      print('Error : $e');
    }
  }
}




