import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naberr_app/message_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Naberr"),
        leading: InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.output)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagePage()));
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  height: 100,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      ".Net Core",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
