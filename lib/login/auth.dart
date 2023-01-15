import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:medicine_hub/login/login_page.dart';
import 'package:medicine_hub/section/home_page.dart';
import 'package:medicine_hub/section/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // user is logged in
          if(snapshot.hasData){
            return HomePage();
          }

          // user is logged out 
          else {
            // debugPrint('Hello ');
             return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
