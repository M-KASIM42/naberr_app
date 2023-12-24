// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:naberr_app/staticfile.dart';
import 'loginpage.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null) {
              if (user.emailVerified) {
                Bilgilerim.email = user.email!;
                return MainPage();
              } else {
                return LoginPage();
              }
            } else {
              return LoginPage();
            }
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}