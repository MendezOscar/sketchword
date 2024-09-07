import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchword/presentation/pages/auth/login.dart';

import '../../../domain/entities/user.dart' as myUser;

import '../../widgets/edit_user_modal.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final db = FirebaseFirestore.instance;
    var myFormat = DateFormat('MMMM d');
    late String userId = "";
    late myUser.User user = myUser.User(
        id: "",
        name: "",
        surname: "",
        birthday: DateTime.now(),
        church: "",
        phone: "",
        email: "");

    Future<String> userEmail = prefs.then((SharedPreferences prefs) {
      var userEmail = prefs.getString('emailUser') ?? "";
      db
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .snapshots()
          .listen((event) async {
        for (var doc in event.docs) {
          userId = doc.reference.id;
          user = myUser.User.fromFirestore(doc, null);
        }
      });
      return userEmail;
    });

    final Future<String> getUserEmail = Future<String>.delayed(
      const Duration(seconds: 1),
      () => userEmail,
    );

    void callNewPointModalBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Center(
                child: UserEditModal(
              userInfo: user,
              userId: userId,
            )),
          );
        },
      ).then((value) => {setState(() {})});
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FutureBuilder(
          future: getUserEmail,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/lotties/perfil.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${user.name} ${user.surname}',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF0879A6)),
                            ),
                            Text(
                              user.church,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Pacifico',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "    Informacion",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0XFF0879A6),
                              radius: 20,
                              child: TextButton(
                                  onPressed: () {
                                    callNewPointModalBottomSheet();
                                    getUserEmail;
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          tileColor: const Color.fromARGB(255, 94, 166, 194),
                          leading: const Icon(Icons.email, color: Colors.white),
                          title: Text(
                            user.email,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          tileColor: const Color.fromARGB(255, 94, 166, 194),
                          leading: const Icon(Icons.phone, color: Colors.white),
                          title: Text(
                            user.phone,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          tileColor: const Color.fromARGB(255, 94, 166, 194),
                          leading: const Icon(Icons.cake, color: Colors.white),
                          title: Text(
                            myFormat.format(user.birthday),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            tileColor: const Color.fromARGB(255, 172, 159, 49),
                            leading:
                                const Icon(Icons.password, color: Colors.white),
                            title: const Text(
                              'Cambiar contrasena',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            tileColor: const Color.fromARGB(255, 233, 128, 109),
                            leading:
                                const Icon(Icons.close, color: Colors.white),
                            title: const Text(
                              'Cerrar sesion',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: TextButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await FirebaseAuth.instance.signOut();
                                await prefs.remove('emailUser');
                                await prefs.remove('userToken');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Login()));
                              },
                              child: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          }),
    );
  }
}
