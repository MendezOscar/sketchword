import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sketchword/domain/entities/point_sketches.dart';
import 'package:sketchword/domain/entities/sketches.dart';
import 'package:sketchword/presentation/pages/home/home.dart';
import 'package:sketchword/presentation/pages/home/new_point.dart';

import '../../widgets/my_app_bar.dart';
import 'edit_point.dart';

class EditSketches extends StatefulWidget {
  final String idUser;
  final String sketchId;
  final Sketches sketchToEdit;

  const EditSketches(
      {super.key,
      required this.idUser,
      required this.sketchId,
      required this.sketchToEdit});

  @override
  State<EditSketches> createState() => _NewSketchesState();
}

class _NewSketchesState extends State<EditSketches> {
  String type = 'Expositivo';
  String category = 'Edificacion';
  late Sketches sketch;
  late List<PointSketches> pointSketches = [];
  late int number;
  late int index;

  TextEditingController title = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController quote = TextEditingController();
  TextEditingController introduction = TextEditingController();
  TextEditingController illustration = TextEditingController();
  TextEditingController conclusion = TextEditingController();

  @override
  void initState() {
    super.initState();
    number = 0;
  }

  @override
  Widget build(BuildContext context) {
    title.text = widget.sketchToEdit.title;
    topic.text = widget.sketchToEdit.topic;
    quote.text = widget.sketchToEdit.quote;
    introduction.text = widget.sketchToEdit.introduction;
    illustration.text = widget.sketchToEdit.illustration ?? "";
    conclusion.text = widget.sketchToEdit.conclusion;
    type = widget.sketchToEdit.type;
    category = widget.sketchToEdit.category;
    pointSketches = widget.sketchToEdit.pointSketches;

    void callNewPointModalBottomSheet(PointSketches pointSketch, int quantity) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Center(
                child: EditPoint(
              quantity: quantity,
              pointSketchToEdit: pointSketch,
            )),
          );
        },
      ).then((value) => {
            if (value == null)
              {}
            else
              {
                index = pointSketches
                    .indexWhere((value) => value.id == pointSketch.id),
                pointSketches[index] = PointSketches(
                    id: value.id,
                    name: value.name,
                    keyWord: value.keyWord,
                    keyDefinition: value.keyDefinition,
                    keyQuote: value.keyQuote,
                    mainIdea: value.mainIdea)
              },
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: MyAppBar(
          title: 'Editar bosquejo',
          icon: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 170, 211, 228),
                ),
                dropdownColor: const Color.fromARGB(255, 170, 211, 228),
                value: category,
                onChanged: (String? newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
                items: <String>[
                  'Cena del Señor',
                  'Edificacion',
                  'Evangelico',
                  'Oracion',
                  'Ocacion especial'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 170, 211, 228),
                ),
                dropdownColor: const Color.fromARGB(255, 170, 211, 228),
                value: type,
                onChanged: (String? newValue) {
                  setState(() {
                    type = newValue!;
                  });
                },
                items: <String>['Expositivo', 'Tematico', 'Textual']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: title,
                decoration: const InputDecoration(
                    prefixIconColor: Color(0XFF0879A6),
                    prefixIcon: Icon(Icons.title),
                    labelText: 'Titulo',
                    labelStyle: TextStyle(color: Color(0XFF0879A6))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: topic,
                decoration: const InputDecoration(
                    prefixIconColor: Color(0XFF0879A6),
                    prefixIcon: Icon(Icons.abc),
                    labelText: 'Tema',
                    labelStyle: TextStyle(color: Color(0XFF0879A6))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: quote,
                decoration: const InputDecoration(
                    prefixIconColor: Color(0XFF0879A6),
                    prefixIcon: Icon(Icons.book_rounded),
                    labelText: 'Cita',
                    labelStyle: TextStyle(color: Color(0XFF0879A6))),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: introduction,
                maxLines: 3,
                decoration: const InputDecoration(
                    prefixIconColor: Color(0XFF0879A6),
                    prefixIcon: Icon(Icons.abc),
                    labelText: 'Introduccion',
                    labelStyle: TextStyle(color: Color(0XFF0879A6))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Puntos",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Agregar nuevo punto',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                      backgroundColor: const Color(0XFF0879A6),
                      child: IconButton(
                          onPressed: () {
                            callNewPointModalBottomSheet(
                                pointSketches[index], pointSketches.length);
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: pointSketches.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      expandedAlignment: Alignment.topLeft,
                      leading: Column(
                        children: [
                          IconButton(
                              iconSize: 20,
                              onPressed: () {
                                callNewPointModalBottomSheet(
                                    pointSketches[index], pointSketches.length);
                              },
                              icon: const Icon(Icons.edit)),
                        ],
                      ),
                      collapsedBackgroundColor:
                          const Color.fromARGB(255, 210, 243, 207),
                      title: Text(pointSketches[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.black)),
                      subtitle: Text('Punto ${(index + 1).toString()}'),
                      children: [
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
                                            color: const Color.fromARGB(
                                                255, 210, 243, 207),
                                            borderRadius: BorderRadius.circular(
                                              25.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              pointSketches[index].keyWord,
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
                                            color: const Color.fromARGB(
                                                255, 210, 243, 207),
                                            borderRadius: BorderRadius.circular(
                                              25.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              pointSketches[index]
                                                  .keyDefinition,
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
                                            color: const Color.fromARGB(
                                                255, 210, 243, 207),
                                            borderRadius: BorderRadius.circular(
                                              25.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              pointSketches[index].keyQuote,
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
                                            color: const Color.fromARGB(
                                                255, 210, 243, 207),
                                            borderRadius: BorderRadius.circular(
                                              25.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              pointSketches[index].mainIdea,
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
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: illustration,
                maxLines: 3,
                decoration: const InputDecoration(
                    prefixIconColor: Color(0XFF0879A6),
                    prefixIcon: Icon(Icons.art_track),
                    labelText: 'Ilustracion',
                    labelStyle: TextStyle(color: Color(0XFF0879A6))),
              ),
              TextField(
                controller: conclusion,
                maxLines: 3,
                decoration: const InputDecoration(
                    prefixIconColor: Color(0XFF0879A6),
                    prefixIcon: Icon(Icons.check),
                    labelText: 'Conclusion',
                    labelStyle: TextStyle(color: Color(0XFF0879A6))),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      sketch = Sketches(
                          owner: widget.idUser,
                          title: title.text,
                          topic: topic.text,
                          quote: quote.text,
                          type: type,
                          category: category,
                          introduction: introduction.text,
                          illustration: illustration.text,
                          conclusion: conclusion.text,
                          pointSketches: pointSketches);

                      if (sketch.title == '' ||
                          sketch.topic == "" ||
                          sketch.quote == "" ||
                          sketch.introduction == "" ||
                          sketch.pointSketches.isEmpty ||
                          sketch.conclusion == "") {
                        final snackBar = SnackBar(
                          content: const Text(
                              'Solo el campo ilustracion no es requerido.'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        editSketches(
                            context, sketch, widget.idUser, widget.sketchId);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Home()));
                      }
                    },
                    label: const Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      child: Text(
                        'GUARDAR',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
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

Future<void> editSketches(
    context, Sketches sketch, String userId, String sketchId) {
  CollectionReference sketches =
      FirebaseFirestore.instance.collection('sketches');
  return sketches.doc(sketchId).update({
    'title': sketch.title,
    'topic': sketch.topic,
    'quote': sketch.quote,
    'type': sketch.type,
    'category': sketch.category,
    'introduction': sketch.introduction,
    'pointSketches': sketch.pointSketches.map((e) => e.toFirestore()).toList(),
    'conclusion': sketch.conclusion,
    'illustration': sketch.illustration,
  }).then((value) {
    SnackBar(
      content: const Text('Bosquejo editado existosamente'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    // ignore: invalid_return_type_for_catch_error
  }).catchError((error) {
    final snackBar = SnackBar(
      content: const Text('Error en la edicion de Bosquejo'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}
