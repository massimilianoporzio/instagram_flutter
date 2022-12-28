import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //* 1. handleAuthState()
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(); //HOME
        } else {
          return Container(); //LOGIN
        }
      },
    );
  }

  //* 2. signInWithGoogle()
  Future<UserCredential> signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //Once signed in, return the UserCredetial
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //* 3. signOut()
  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
