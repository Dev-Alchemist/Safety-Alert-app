import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:students_safety_app/views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safety App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
            primarySwatch:Colors.blue
      ),
      home: SignIn(),

    );
  }
}



