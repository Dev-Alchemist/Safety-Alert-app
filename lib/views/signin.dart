import 'package:flutter/material.dart';
import 'package:students_safety_app/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("Sign in")
          ],
        ),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 50)
                  ),
                  onPressed: () {
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Text("Sign In With Google"),
                ),
            )
          ],
        ),
      ),
    );
  }
}
