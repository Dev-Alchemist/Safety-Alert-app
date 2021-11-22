import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_safety_app/helper_functions/database_helper.dart';
import 'package:students_safety_app/helper_functions/shared_preferences.dart';
import 'package:students_safety_app/services/auth.dart';
import 'package:students_safety_app/utils/NotificationUtil.dart';
import 'package:students_safety_app/views/settings.dart';
import 'package:students_safety_app/views/signin.dart';

import 'add_contact.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String? userName, userEmail, imageUrl;

  @override
  void initState() {
    super.initState();

    // Prepare elements for drawer widget
    SharedPreferenceHelper.getUserNameKey()
        .then((value) => setState(() => {userName = value}));
    SharedPreferenceHelper.getUserEmail()
        .then((value) => setState(() => {userEmail = value}));
    SharedPreferenceHelper.getUserProfilePicKey()
        .then((value) => setState(() => {imageUrl = value}));

    // Update SOS Shared Prefs
    SharedPreferenceHelper.getMessageHead().then((value) async {
      if (value != null) {
        print('MessageHead is $value');
      } else {
        print('MessageHead is $value');
        value = "HI, plz help me. Reach this location: ";
        SharedPreferenceHelper.saveMessageHead(value);
      }
    });

    SharedPreferenceHelper.getSOSdelayTime().then((value) async {
      if (value != null) {
        print('SOS delayTime is $value');
      } else {
        print('SOS delayTime is $value');
        value = 5;
        SharedPreferenceHelper.saveSOSdelayTime(value);
      }
    });

    SharedPreferenceHelper.getSOSrepeatInterval().then((value) async {
      if (value != null) {
        print('SOS repeat interval is $value');
      } else {
        print('SOS repeat interval is $value');
        value = 100;
        SharedPreferenceHelper.saveSOSrepeatInterval(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              currentAccountPicture: imageUrl == null
                  ? Icon(Icons.account_circle_rounded, size: 55)
                  : new CircleAvatar(backgroundImage: NetworkImage(imageUrl!)),
            ),
            new ListTile(
              title: Text("Settings"),
              subtitle: Text("Message...."),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              trailing: FittedBox(
                child: Icon(Icons.settings, size: 35),
              ),
            ),
            new ListTile(
              title: Text("Logout"),
              tileColor: Colors.grey[300],
              onTap: () {
                AuthMethods().signOut();
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 196, 16, 5),
              child: Column(
                children: [
                  Text(
                    "Send Emergency",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 21),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                    child: Text(
                      "SOS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Image.asset(
                  "assets/alert.jpg",
                  height: size.height * 0.1,
                ),
                onPressed: () {
                  _triggerSendSOS();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0, right: 60, left: 60),
              child: ElevatedButton(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30.0, top: 8, bottom: 8, right: 8),
                      child: Image.asset(
                        "assets/contact.jpg",
                        height: size.height * 0.05,
                      ),
                    ),
                    Text(
                      "Add Contact",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 21),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddContacts()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _triggerSendSOS() async {
    int? count = await databaseHelper.getCount();

    if (count == 0) {
      log("Please Add Trusted Contacts to contacts");
      Fluttertoast.showToast(
          msg: 'Please Add Trusted contacts to send SOS.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.redAccent);
    } else {
      NotificationUtil.Notify(1337);
      Fluttertoast.showToast(
          msg: 'Sending SOS.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green);
    }
  }
}
