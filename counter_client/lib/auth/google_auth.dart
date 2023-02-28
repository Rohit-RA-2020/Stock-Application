import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

void googleLogin(BuildContext context) async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();

  if (googleUser == null) {
    return null;
  }

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  try {
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}
