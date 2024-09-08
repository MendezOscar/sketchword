import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sketchword/presentation/pages/home/new_edit_sketches.dart';

import '../../domain/entities/sketches.dart';
import '../pages/home/edit_sketches.dart';
import '../pages/home/home.dart';
import 'my_app_bar.dart';

class Sketch extends StatelessWidget {
  final Sketches sketch;
  final String sketchId;
  final bool isExample;
  final String userId;

  const Sketch(
      {super.key,
      required this.sketch,
      required this.sketchId,
      required this.isExample,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color(0XFF0879A6)),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sketch.title,
                style: const TextStyle(
                    color: Color(0XFF0879A6),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                sketch.topic,
                style: const TextStyle(
                    fontWeight: FontWeight.w100, fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                sketch.quote,
                style: const TextStyle(
                    fontWeight: FontWeight.w100, fontStyle: FontStyle.italic),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 207, 232, 243),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(sketch.category)),
                          ))),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 239, 183),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(sketch.type)),
                          ))),
                  const SizedBox(
                    width: 5,
                  ),
                  // CircleAvatar(
                  //   backgroundColor: const Color(0XFF0879A6),
                  //   child: TextButton(
                  //       style: TextButton.styleFrom(
                  //           backgroundColor: Colors.transparent,
                  //           shadowColor: Colors.transparent),
                  //       onPressed: () {},
                  //       child: const Icon(
                  //         Icons.post_add,
                  //         color: Colors.white,
                  //       )),
                  // ),
                  const SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0XFF0879A6),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewSketch(
                                    sketch: sketch,
                                    sketchId: sketchId,
                                    isExample: isExample,
                                  )));
                        },
                        child: const Icon(
                          size: 15,
                          Icons.remove_red_eye,
                          color: Colors.white,
                        )),
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

class ViewSketch extends StatelessWidget {
  final bool isExample;
  final Sketches sketch;
  final String sketchId;
  const ViewSketch(
      {super.key,
      required this.sketch,
      required this.sketchId,
      required this.isExample});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: MyAppBar(
          title: 'Bosquejo',
          icon: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                sketch.title,
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Pacifico',
                    color: Color(0XFF0879A6)),
              ),
              Text(
                sketch.topic,
                style: const TextStyle(fontSize: 18, color: Color(0XFF0879A6)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    sketch.quote,
                    style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 207, 232, 243),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(sketch.category)),
                          ))),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 239, 183),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text(sketch.type)),
                          ))),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElementDetails(
                name: 'Introducción',
                description: sketch.introduction,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sketch.pointSketches.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PointDetails(
                      pointNumber: index + 1,
                      name: sketch.pointSketches[index].name,
                      keyWord: sketch.pointSketches[index].keyWord,
                      keyDefinition: sketch.pointSketches[index].keyDefinition,
                      keyQuote: sketch.pointSketches[index].keyQuote,
                      mainIdea: sketch.pointSketches[index].mainIdea,
                    );
                  }),
              ElementDetails(
                name: 'Ilustración',
                description: sketch.illustration ?? "",
              ),
              ElementDetails(
                name: 'Conclusión',
                description: sketch.conclusion,
              ),
              const SizedBox(
                height: 15,
              ),
              isExample == true
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              const Color.fromARGB(255, 245, 145, 162),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              onPressed: () {
                                deleteUser(sketchId, context);
                              },
                              child: const Icon(
                                size: 15,
                                Icons.delete,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0XFF0879A6),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditSketches(
                                          idUser: "",
                                          sketchId: sketchId,
                                          sketchToEdit: sketch,
                                        )));
                              },
                              child: const Icon(
                                size: 15,
                                Icons.edit,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        // CircleAvatar(
                        //   radius: 20,
                        //   backgroundColor: const Color(0XFF0879A6),
                        //   child: TextButton(
                        //       style: TextButton.styleFrom(
                        //           backgroundColor: Colors.transparent,
                        //           shadowColor: Colors.transparent),
                        //       onPressed: () {},
                        //       child: const Icon(
                        //         Icons.post_add,
                        //         color: Colors.white,
                        //       )),
                        // ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        // CircleAvatar(
                        //   radius: 20,
                        //   backgroundColor: const Color(0XFF0879A6),
                        //   child: TextButton(
                        //       style: TextButton.styleFrom(
                        //           backgroundColor: Colors.transparent,
                        //           shadowColor: Colors.transparent),
                        //       onPressed: () {},
                        //       child: const Icon(
                        //         size: 15,
                        //         Icons.favorite,
                        //         color: Colors.white,
                        //       )),
                        // )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> deleteUser(String sketchId, context) {
  CollectionReference users = FirebaseFirestore.instance.collection('sketches');

  return users.doc(sketchId).delete().then((value) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Home()));
  }).catchError((error) => print("Failed to delete user: $error"));
}

class ElementDetails extends StatelessWidget {
  final String name;
  final String description;
  const ElementDetails({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: const Color.fromARGB(255, 207, 232, 243),
      title: Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            color: Colors.black),
      ),
      subtitle: const Text(
        'Expandir para ver mas',
        style: TextStyle(),
      ),
      children: <Widget>[
        ListTile(title: Text(description)),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class PointDetails extends StatelessWidget {
  final String name;
  final String keyWord;
  final String keyDefinition;
  final String keyQuote;
  final String mainIdea;
  final int pointNumber;
  const PointDetails({
    super.key,
    required this.name,
    required this.keyWord,
    required this.keyDefinition,
    required this.keyQuote,
    required this.mainIdea,
    required this.pointNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      collapsedBackgroundColor: const Color.fromARGB(255, 210, 243, 207),
      title: Text(name,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.black)),
      subtitle: Text('Punto $pointNumber'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Oracion o palabra clave: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 210, 243, 207),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              keyWord,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Definicion de oracion o palabra clave: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 210, 243, 207),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              keyDefinition,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Citas de apoyo o contexto: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 210, 243, 207),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              keyQuote,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 15,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Idea principal: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 210, 243, 207),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              mainIdea,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
