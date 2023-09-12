import 'package:flutter/material.dart';
import 'package:todoapp/screen/login.dart';
import 'package:todoapp/screen/signup.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FractionallySizedBox(
              widthFactor: 1.0,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Text('Login',style: TextStyle(fontSize: 23),),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: OutlinedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                  child: Text('SignUp',style: TextStyle(fontSize: 23),),
              ),
            ),
            SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}
