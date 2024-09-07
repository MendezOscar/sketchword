import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget icon;
  const MyAppBar({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: const Color(0XFF0879A6),
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Pacifico', color: Colors.white),
      ),
    );
  }
}
