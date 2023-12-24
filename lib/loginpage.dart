// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naberr_app/registerpage.dart';
import 'package:naberr_app/staticfile.dart';

import 'forgotpassword.dart';
import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 193, 80),
            body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Text(
              "Naberr",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                    },
                    child: Text("Forgot Password",style: TextStyle(color: Colors.blue),),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
  onPressed: () async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      // Kullanıcının e-posta doğrulaması yapılmış mı kontrol etme
      if (userCredential.user != null) {
        User user = userCredential.user!;
        if (user.emailVerified) {
          Bilgilerim.email = user.email!;
          Navigator.push(context, MaterialPageRoute(builder: (mymainpage)=>MainPage()));
        } else {
          // E-posta doğrulaması yapılmamış kullanıcı
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("E-posta Doğrulaması Gerekli"),
                content: Text(
                    "Lütfen e-posta adresinizi doğrulayın. Doğrulama bağlantısı için e-posta gönderildi."),
              );
            },
          );
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            content: Text("Bilgilerinizi kontrol edip tekrar deneyin!"),
          );
        },
      );
    }
  },
  child: Text("Giriş Yap"),
),

            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hesabın yok mu "),
                TextButton(child: Text("Kayıt Ol"),onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (RegisterContex)=> RegisterPage()));
                },)
              ],
            )
          ],
        ),
      ),
    );
  }
}
