import 'package:cloud_firestore/cloud_firestore.dart';
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
    var user = await FirebaseAuth.instance.signInWithCredential(credential);
    // create a empty user document in firestore
    user.additionalUserInfo!.isNewUser
        ? await FirebaseFirestore.instance
            .collection('portfolio')
            .doc(user.user!.uid)
            .set({
            'stocks': [],
            'balance': 0.0,
          })
        : null;

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const QuestionGreet(),
      ),
      (route) => false,
    );
  } on FirebaseAuthException catch (e) {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message!),
      ),
    );
  }
}
