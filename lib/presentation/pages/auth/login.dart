import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchword/presentation/pages/auth/register.dart';
import 'package:sketchword/presentation/pages/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  late bool viewPassword = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset('assets/images/lotties/logologin.png'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.mail),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Correo',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  obscureText: viewPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (viewPassword) {
                                viewPassword = false;
                              } else {
                                viewPassword = true;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye)),
                      suffixIconColor: const Color(0XFF0879A6),
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.security),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0XFF0879A6),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: const BorderSide(color: Color(0XFF0879A6)),
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 20, color: Color(0XFF0879A6))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Register()));
                    },
                    label: const Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Text(
                        'REGISTRARSE',
                        style: TextStyle(
                          color: Color(0XFF0879A6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        side: const BorderSide(color: Colors.white),
                        backgroundColor: const Color(0XFF0879A6),
                        textStyle: const TextStyle(
                            fontSize: 20, color: Color(0XFF0879A6))),
                    onPressed: () {
                      _signInWithEmailAndPassword(
                          context, email.text, password.text);
                    },
                    label: const Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _signInWithEmailAndPassword(context, email, password) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var token = await FirebaseAuth.instance.currentUser?.getIdToken();

    await prefs.setString('emailUser', email);
    await prefs.setString('userToken', token ?? "");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Home()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      final snackBar = SnackBar(
        content: const Text('No se encontro este usuario'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (e.code == 'wrong-password') {
      final snackBar = SnackBar(
        content: const Text('Contrasena incorrecta'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: const Text('Usuario o contraseña incorrecta'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
