import 'package:flutter/material.dart';

import '../../../domain/entities/point_sketches.dart';

class NewPoint extends StatefulWidget {
  final bool isEditing;
  final int quantity;
  final PointSketches? pointSketchToEdit;

  const NewPoint(
      {super.key,
      required this.isEditing,
      required this.quantity,
      this.pointSketchToEdit});

  @override
  State<NewPoint> createState() => _NewPointState();
}

class _NewPointState extends State<NewPoint> {
  TextEditingController name = TextEditingController();
  TextEditingController keyWord = TextEditingController();
  TextEditingController keyDefinition = TextEditingController();
  TextEditingController keyQuote = TextEditingController();
  TextEditingController mainIdea = TextEditingController();
  PointSketches? pointSketch;
  late PointSketches newPointSketch;

  @override
  Widget build(BuildContext context) {
    name.text = widget.pointSketchToEdit?.name ?? '';
    keyWord.text = widget.pointSketchToEdit?.keyWord ?? '';
    keyDefinition.text = widget.pointSketchToEdit?.keyDefinition ?? '';
    keyQuote.text = widget.pointSketchToEdit?.keyQuote ?? '';
    mainIdea.text = widget.pointSketchToEdit?.mainIdea ?? '';

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Punto del bosquejo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          TextField(
            controller: name,
            decoration: const InputDecoration(
                prefixIconColor: Color(0XFF0879A6),
                prefixIcon: Icon(Icons.title),
                labelText: 'Nombre del punto',
                labelStyle: TextStyle(color: Color(0XFF0879A6))),
          ),
          const SizedBox(
            width: 10,
          ),
          TextField(
            controller: keyWord,
            decoration: const InputDecoration(
                prefixIconColor: Color(0XFF0879A6),
                prefixIcon: Icon(Icons.key),
                labelText: 'Oracion o palabra clave',
                labelStyle: TextStyle(color: Color(0XFF0879A6))),
          ),
          TextField(
            controller: keyDefinition,
            maxLines: 2,
            decoration: const InputDecoration(
                prefixIconColor: Color(0XFF0879A6),
                prefixIcon: Icon(Icons.abc),
                labelText: 'Definicion de oracion o palabra clase',
                labelStyle: TextStyle(color: Color(0XFF0879A6))),
          ),
          TextField(
            controller: keyQuote,
            decoration: const InputDecoration(
                prefixIconColor: Color(0XFF0879A6),
                prefixIcon: Icon(Icons.book),
                labelText: 'Citas de apoyo o contexto',
                labelStyle: TextStyle(color: Color(0XFF0879A6))),
          ),
          TextField(
            controller: mainIdea,
            maxLines: 5,
            decoration: const InputDecoration(
                prefixIconColor: Color(0XFF0879A6),
                prefixIcon: Icon(Icons.abc),
                labelText: 'Idea principal',
                labelStyle: TextStyle(color: Color(0XFF0879A6))),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            '* Todos los campos son requeridos',
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 201, 114, 114),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ))),
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                  backgroundColor: const Color(0XFF0879A6),
                  child: IconButton(
                      onPressed: () {
                        if (widget.isEditing) {
                          newPointSketch = PointSketches(
                              id: widget.isEditing
                                  ? widget.pointSketchToEdit!.id
                                  : widget.quantity + 1,
                              name: name.text,
                              keyWord: keyWord.text,
                              keyDefinition: keyDefinition.text,
                              keyQuote: keyQuote.text,
                              mainIdea: mainIdea.text);
                          if (newPointSketch.name == '' ||
                              newPointSketch.keyWord == '' ||
                              newPointSketch.keyDefinition == '' ||
                              newPointSketch.mainIdea == '') {
                          } else {
                            Navigator.pop(context, newPointSketch);
                          }
                        } else {
                          pointSketch = PointSketches(
                              id: widget.isEditing
                                  ? widget.pointSketchToEdit!.id
                                  : widget.quantity + 1,
                              name: name.text,
                              keyWord: keyWord.text,
                              keyDefinition: keyDefinition.text,
                              keyQuote: keyQuote.text,
                              mainIdea: mainIdea.text);
                          if (pointSketch?.name == '' ||
                              pointSketch?.keyWord == '' ||
                              pointSketch?.keyDefinition == '' ||
                              pointSketch?.mainIdea == '') {
                          } else {
                            Navigator.pop(context, pointSketch);
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      )))
            ],
          )
        ],
      ),
    );
  }
}
