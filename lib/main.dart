import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sketchword/presentation/pages/auth/login.dart';
import 'package:sketchword/presentation/pages/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      runApp(const MyApp(auth: false));
    } else {
      runApp(const MyApp(auth: true));
    }
  });
}

class MyApp extends StatelessWidget {
  final bool auth;
  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lora'),
      color: const Color(0XFF0879A6),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: auth ? const Home() : const Login(),
      ),
    );
  }
}
