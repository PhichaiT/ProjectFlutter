import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:widgets_basic/login_sucess_page.dart';
import 'package:widgets_basic/sign_in/sign_in.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body : StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return LoginSucessPage();
            } else {
              return const SignInScreen();
            }
          }
        },
      ),
    );
  }
}