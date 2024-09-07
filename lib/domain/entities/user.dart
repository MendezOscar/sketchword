import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final DateTime birthday;
  final String church;
  final String phone;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.church,
    required this.phone,
    required this.email,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      id: data?['id'],
      name: data?['name'],
      surname: data?['surname'],
      birthday: (data?['birthday'] as Timestamp).toDate(),
      church: data?['church'],
      phone: data?['phone'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "birthday": birthday,
      "church": church,
      "prone": phone,
      "email": email,
    };
  }
}
