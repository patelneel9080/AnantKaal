import 'package:anantkaal/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDrvYfkthSeE0GChsEULIgK_PL5no8yBzI",
          appId: "1:527991928161:android:837479d699481f3c650120",
          messagingSenderId: "527991928161",
          projectId: "anantkaal-7a6e3"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anantkaal Assignment',
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

