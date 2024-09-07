import 'package:cloud_firestore/cloud_firestore.dart';

class PointSketches {
  PointSketches(
      {required this.id,
      required this.name,
      required this.keyWord,
      required this.keyDefinition,
      required this.keyQuote,
      required this.mainIdea});

  final int id;
  final String name;
  final String keyWord;
  final String keyDefinition;
  final String keyQuote;
  final String mainIdea;

  factory PointSketches.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PointSketches(
      id: data?['id'],
      name: data?['name'],
      keyWord: data?['name'],
      keyDefinition: data?['state'],
      keyQuote: data?['country'],
      mainIdea: data?['capital'],
    );
  }

  factory PointSketches.fromFire(
    Map<String, dynamic> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot;
    return PointSketches(
      id: data['id'],
      name: data['name'],
      keyWord: data['keyWord'],
      keyDefinition: data['keyDefinition'],
      keyQuote: data['keyQuote'],
      mainIdea: data['mainIdea'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'keyWord': keyWord,
      'keyDefinition': keyDefinition,
      'keyQuote': keyQuote,
      'mainIdea': mainIdea
    };
  }
}
