import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/user.dart';

class UserEditModal extends StatefulWidget {
  const UserEditModal(
      {super.key, required this.userInfo, required this.userId});

  final User userInfo;
  final String userId;

  @override
  State<UserEditModal> createState() => _UserEditModalState();
}

class _UserEditModalState extends State<UserEditModal> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController church = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = widget.userInfo.name;
    surname.text = widget.userInfo.surname;
    birthday.text = widget.userInfo.birthday.toString();
    church.text = widget.userInfo.church;
    phone.text = widget.userInfo.phone;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const Text(
            "    Editar informacion del usuario",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16),
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
                String formattedDate = DateFormat('MMMM d').format(pickedDate);
                setState(() {});
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
                  Navigator.of(context).pop();
                },
                label: const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
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
                width: 5,
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
                  updateUser(
                      widget.userId,
                      User(
                          id: widget.userId,
                          name: name.text,
                          surname: surname.text,
                          birthday: DateTime.parse(birthday.text),
                          church: church.text,
                          phone: phone.text,
                          email: ""));
                  Navigator.of(context).pop();
                },
                label: const Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                  child: Text(
                    'GUARDAR',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}

Future<void> updateUser(String userId, User user) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return users
      .doc(userId)
      .update({
        'name': user.name,
        'surname': user.surname,
        'church': user.church,
        'birthday': user.birthday,
        'phone': user.phone
      })
      .then((value) => print("User email updated successfully!"))
      .catchError((error) => print("Failed to update user email: $error"));
}
