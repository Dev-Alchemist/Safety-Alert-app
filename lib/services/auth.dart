import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:students_safety_app/views/home.dart';

class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get current user
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  // sign in with google
  Future<User?> signInWithGoogle(BuildContext context) async {
    log("Trying to login with google");

    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken:  googleSignInAuthentication.idToken,
          accessToken:  googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(credential);

      User? userDetails = result.user;

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home()));
      Fluttertoast.showToast(msg: "Signed in as ${userDetails!.displayName}");

      return userDetails;
    } catch (e){
      log(e.toString());
      Fluttertoast.showToast(msg: "Network Error! Please try later.");
      return null;

    }
  }
}