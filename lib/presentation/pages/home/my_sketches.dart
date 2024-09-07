import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchword/presentation/pages/home/my_all_sketches.dart';
import 'package:sketchword/presentation/widgets/welcome_card.dart';

class MySketches extends StatefulWidget {
  const MySketches({super.key});

  @override
  State<MySketches> createState() => _MySketchesState();
}

class _MySketchesState extends State<MySketches> {
  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final db = FirebaseFirestore.instance;

    String? idUser;
    late Map<String, dynamic> user = {
      "id": "",
      "name": "",
      "surnName": "",
      "birthday": "",
      "church": "",
      "dateOfBirth": "",
      "phone": "",
      "email": "",
    };

    Future<String> userEmail = prefs.then((SharedPreferences prefs) {
      var userEmail = prefs.getString('emailUser') ?? "";
      db
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .snapshots()
          .listen((event) async {
        for (var doc in event.docs) {
          user = doc.data();
          idUser = user["id"];
          print(idUser);
        }
      });
      return userEmail;
    });

    final Future<String> getUserEmail = Future<String>.delayed(
      const Duration(seconds: 1),
      () => userEmail,
    );

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: getUserEmail,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 207, 232, 243),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                WelcomeCard(
                                  name: user["name"],
                                  idUser: user["id"],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyAllSketches(idUser: idUser ?? '')
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const WelcomeCard(
                      name: '',
                      idUser: '',
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
