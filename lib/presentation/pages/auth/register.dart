import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sketchword/presentation/pages/auth/login.dart';

import '../../widgets/my_app_bar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController church = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();

  @override
  void initState() {
    birthday.text = "";
    name.text = "";
    surname.text = "";
    church.text = "";
    email.text = "";
    phone.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: MyAppBar(
            title: 'Resgistro',
            icon: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "    Informacion del usuario",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Nombre',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: surname,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Apellido',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: church,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Sala Evangelica',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: phone,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.phone),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Telefono',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: birthday,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        birthday.text = formattedDate;
                      });
                    } else {}
                  },
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.calendar_month),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Fecha de nacimiento',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "    Cuenta",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Correo',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.security),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Contrasena',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  controller: repeatPassword,
                  decoration: InputDecoration(
                      prefixIconColor: const Color(0XFF0879A6),
                      prefixIcon: const Icon(Icons.security),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF0879A6)),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Reperir contrasena',
                      labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                ),
                const SizedBox(
                  height: 40,
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
                            builder: (context) => const Login()));
                      },
                      label: const Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        child: Text(
                          'CANCELAR',
                          style: TextStyle(
                            color: Color(0XFF0879A6),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 1,
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
                        if (password.text == repeatPassword.text &&
                            password.text.length > 6) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Login()));
                          addUser(
                              name.text,
                              email.text,
                              surname.text,
                              church.text,
                              phone.text,
                              DateTime.parse(birthday.text),
                              password.text,
                              repeatPassword.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                  child: Text(
                                      "Contrasenas no coinciden o deben ser mayores a 6 caracteres")),
                            ),
                          );
                        }
                      },
                      label: const Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        child: Text(
                          'REGISTRARSE',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

Future<void> handleSignUp(email, password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  await auth.createUserWithEmailAndPassword(email: email, password: password);
}

String firestoreAutoId() {
  Random random = Random();
  const chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  var autoId = "";

  //autoId += CHARS.charAt(Math.floor(Math.random() * CHARS.length));

  for (var i = 0; i < 20; i++) {
    autoId += chars[random.nextInt(chars.length)];
  }
  return autoId;
}

Future<void> addUser(String name, String email, String surname, String church,
    String phone, DateTime birthday, String password, String repeatPassword) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return users.add({
    "id": firestoreAutoId(),
    'name': name,
    'surname': surname,
    'birthday': birthday,
    'church': church,
    'phone': phone,
    'email': email
  }).then((value) {
    SnackBar(
      content: const Text('Usuario creado existosamente'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    handleSignUp(email, password);
    // ignore: invalid_return_type_for_catch_error
  }).catchError((error) => SnackBar(
        content: const Text('Error en la creacion de usuario'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ));
}
