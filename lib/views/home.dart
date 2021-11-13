
import 'package:flutter/material.dart';
import 'package:students_safety_app/helper_functions/shared_preferences.dart';
import 'package:students_safety_app/services/auth.dart';
import 'package:students_safety_app/views/signin.dart';

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
            new ListTile(
              title: Text("Settings"),
              subtitle: Text("Message...."),
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
            topLeft:Radius.circular(40.0),
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero
          )
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 5),
                child: Column(
                  children: [
                    Text("Send Emergency",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize:21
                    ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                        child: Text("SOS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize:28
                          ),
                        ),
                    )
                  ],
                ),
            ),
            Center(
              child: ElevatedButton(
                child: Image.asset("assets/alert.jpg",
                height: size.height * 0.1,
                  color: Colors.white,
                ),
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(30),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0)
                  )
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 40.0, right: 60, left: 60),
                child: ElevatedButton(
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only
                        (left: 30.0, top: 8, bottom: 8, right: 8),
                        child: Image.asset("assets/add_alert.jpg",
                        height: size.height * 0.05,
                          color: Colors.white,
                        ),
                      ),
                      Text("Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 21
                      ),
                      )
                    ],
                  ),
                  onPressed: () {
                    },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    padding:EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)
                    )
                  ),
                ),
            )
          ],
        ),
      ),
      
    );
  }

  void _triggerSendSOS() async {

  }
}
