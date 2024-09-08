import 'package:flutter/material.dart';
import 'package:sketchword/presentation/pages/home/new_edit_sketches.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
    required this.name,
    required this.idUser,
  });

  final String name;
  final String idUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/lotties/perfil.png'),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola, $name',
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0XFF0879A6),
                  fontFamily: 'Pacifico',
                ),
              ),
              const Text('Bienvenido, Cual es tu bosquejo de hoy?'),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewSketches(
                          idUser: idUser,
                          sketchId: '',
                        )));
              },
              child: const Icon(
                Icons.add,
                color: Color(0XFF0879A6),
                size: 25,
              )),
        )
      ],
    );
  }
}
