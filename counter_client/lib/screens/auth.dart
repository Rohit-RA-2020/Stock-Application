import 'package:counter_client/auth/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome, Please login to continue',
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoMono(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // add a lottie file
              Lottie.asset(
                'assets/lottie/login.json',
                width: 300,
                height: 300,
              ),
              GoogleAuthButton(
                onPressed: () {
                  googleLogin(context);
                },
                style: const AuthButtonStyle(
                  buttonType: AuthButtonType.secondary,
                  iconType: AuthIconType.outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
