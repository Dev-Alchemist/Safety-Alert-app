
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? userName, userEmail,imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.orange,
         shadowColor: Colors.white,
         title: Text(
              "Pin Location",
           style: TextStyle(color: Colors.black),
         ),
         centerTitle: true,
       ),
    );
  }
}
