import 'package:counter_client/screens/question_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    await FirebaseAuth.instance.signInWithCredential(credential);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuestionGreet(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}
