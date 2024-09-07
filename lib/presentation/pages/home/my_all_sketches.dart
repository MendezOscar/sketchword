import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchword/domain/entities/sketches.dart';
import '../../../domain/entities/point_sketches.dart';
import '../../widgets/sketch.dart';

class MyAllSketches extends StatelessWidget {
  final String idUser;
  const MyAllSketches({super.key, required this.idUser});

  @override
  Widget build(BuildContext context) {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final db = FirebaseFirestore.instance;
    late List<Sketches>? sketches = [];
    late String sketchId;

    Future<String> userEmail = prefs.then((SharedPreferences prefs) {
      var userEmail = prefs.getString('emailUser') ?? "";
      db
          .collection("sketches")
          .where("owner", isEqualTo: idUser)
          .snapshots()
          .listen((event) {
        for (var doc in event.docs) {
          sketchId = doc.id;
          sketches.add(Sketches.fromFirestore(doc, null));
        }
      });
      return userEmail;
    });

    final Future<String> getUserEmail = Future<String>.delayed(
      const Duration(seconds: 1),
      () => userEmail,
    );

    List<PointSketches> examplePointSketches = [
      PointSketches(
          id: 0,
          name: 'Consideración',
          keyWord: 'Así que',
          keyDefinition:
              'Introduce una idea que expresa una consecuencia lógica de la oración principal',
          keyQuote: 'Juan 8:34',
          mainIdea:
              'esta pequeña expresión nos lleva analizar lo que el mismo Jesús viene diciendo tocante al tema, y justo el verso 34 nos dice: que todo aquel que hace pecado, esclavo es del pecado. ¡Aja!, ¿te consideras libre ahora?'),
      PointSketches(
          id: 1,
          name: 'Condición',
          keyWord: 'si el Hijo os libertare',
          keyDefinition: 'La expresión "sí" establece la condición',
          keyQuote: 'Hechos 4:12',
          mainIdea:
              'La expresión "sí" establece la condición única para obtener la verdadera libertad, en el Hijo'),
      PointSketches(
          id: 2,
          name: 'Certeza',
          keyWord: 'seréis verdaderamente libres',
          keyDefinition: 'Seréis verdaderamente establece seguridad',
          keyQuote: 'Hechos 16:31',
          mainIdea:
              'esta última expresión denota un efecto inmediato, seguro y eterno, la expresión verdaderamente nos habla de la alusión del hombre al sentirse "libre" ajeno a la realidad de su esclavitud (EL PECADO).'),
    ];
    Sketches exampleSketch = Sketches(
        owner: 'Oscar',
        title: ' ¿Verdaderamente libres?',
        topic: '3 Grandes aspectos de una verdadera libertad',
        quote: 'Juan 8.36',
        type: 'Textual',
        category: 'Evangelio',
        introduction:
            'En este mes, es nuestro país, se celebra la independencia, en el escudo nacional se lee una leyenda que dice: libre, soberana e independiente, pero la pregunta es: ¿somos verdaderamente libres?',
        illustration:
            'El Presidente Abraham Lincoln emitió la Proclamación de Emancipación el 1ro de enero de 1863, cuando la nación se acercaba a su tercer año de la guerra civil sangrienta. La proclamación declaró “que todas las personas detenidas como esclavos” dentro de los estados rebeldes “son, y en adelante serán libres.” ',
        conclusion:
            'Eres esclavo del pecado, Jesucristo es el único que puede darte la verdadera libertad.',
        pointSketches: examplePointSketches);

    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "    Ejemplo",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Sketch(
                sketchId: '',
                sketch: exampleSketch,
                isExample: true,
                userId: '',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "    Mis bosquejos",
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: getUserEmail,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: sketches.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Sketch(
                              sketchId: sketchId,
                              sketch: sketches[index],
                              isExample: false,
                              userId: idUser,
                            ),
                          ],
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }
}
