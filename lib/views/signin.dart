import 'package:flutter/material.dart';
import 'package:students_safety_app/services/auth.dart';
import 'package:students_safety_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return

         Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Column(
                children: [Text("Sign in")],
              ),
            ),
            backgroundColor: Colors.blue,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: Image(
                        image: AssetImage("assets/happy.jpg"),
                        height: size.height * 0.35,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 150.0),
                      width: 300,
                      child: ButtonTheme(
                        buttonColor: Colors.white,
                        child: RaisedButton(
                          onPressed: () {

                            AuthMethods().signInWithGoogle(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 13, right: 17, bottom: 13, left: 7),
                                child: Image(
                                  image: AssetImage("assets/google.jpg"),
                                  height: size.height * 0.05,
                                )),
                            Text(
                              "Sign In with Google",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
