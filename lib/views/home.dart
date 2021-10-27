
import 'package:flutter/material.dart';
import 'package:students_safety_app/helper_functions/shared_preferences.dart';
import 'package:students_safety_app/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? userName, userEmail,imageUrl;

  @override
  void initState() {
    super.initState();


    // Prepare elements for drawer widget
    SharedPreferenceHelper.getUserNameKey().then((value) => setState(() => {
      userName = value
    }));
    SharedPreferenceHelper.getUserEmail().then((value) => setState(() => {
      userEmail = value
    }));
    SharedPreferenceHelper.getUserProfilePicKey().then((value) => setState(() => {
      imageUrl = value
    }));
  }

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
      drawer: new Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            new UserAccountsDrawerHeader(
                accountName: new Text(userName == null ? "" : userName!),
                accountEmail: new Text(userEmail == null ? "" : userEmail!),
                currentAccountPicture: imageUrl == null ?
                    Icon(Icons.account_circle_rounded, size: 55) :
                new CircleAvatar(backgroundImage: NetworkImage(imageUrl!)
                ),
            ),

          ],
        ),
      ),
    );
  }
}
