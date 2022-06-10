import 'package:chat_app/register/login.dart';
import 'package:chat_app/register/signup.dart';
import 'package:chat_app/welcome/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rename/rename.dart';

import 'chatscreen/chatpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: _auth.currentUser != null ? "chatpage" : "welcomepage",
      routes: {
        "welcomepage": (context) => Welcome(),
        "login": (context) => Login(),
        "signup": (context) => Signup(),
        "chatpage": (context) => Chatpage()
      },
      home: Welcome(),
    );
  }
}
