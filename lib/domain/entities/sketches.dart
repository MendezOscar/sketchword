import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sketchword/domain/entities/point_sketches.dart';

class Sketches {
  final String owner;
  final String title;
  final String topic;
  final String quote;
  final String type;
  final String category;
  final List<PointSketches> pointSketches;
  final String introduction;
  final String? illustration;
  final String conclusion;

  Sketches(
      {required this.owner,
      required this.title,
      required this.topic,
      required this.quote,
      required this.type,
      required this.category,
      required this.introduction,
      required this.illustration,
      required this.conclusion,
      required this.pointSketches});

  factory Sketches.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Sketches(
      owner: data?['owner'],
      title: data?['title'],
      topic: data?['topic'],
      quote: data?['quote'],
      type: data?['type'],
      category: data?['category'],
      introduction: data?['introduction'],
      illustration: data?['illustration'],
      conclusion: data?['conclusion'],
      pointSketches: (data?['pointSketches'] as List<dynamic>)
          .map((e) => PointSketches.fromFire(e as Map<String, dynamic>, null))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "owner": owner,
      "title": title,
      "topic": topic,
      "quote": quote,
      "type": type,
      "category": category,
      "introduction": introduction,
      "pointSketches": pointSketches.map((e) => e.toFirestore()).toList(),
      "illustration": illustration,
      "conclusion": conclusion,
    };
  }
}
