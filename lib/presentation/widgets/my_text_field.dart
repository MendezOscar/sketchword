import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.email,
    required this.label,
    required this.obscureText,
  });

  final TextEditingController email;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: email,
      obscureText: obscureText,
      decoration: InputDecoration(
          prefixIconColor: const Color(0XFF0879A6),
          prefixIcon: const Icon(Icons.mail),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF0879A6)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          labelText: label,
          labelStyle: const TextStyle(color: Color(0XFF0879A6))),
    );
  }
}
