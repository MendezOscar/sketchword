import 'package:flutter/material.dart';
import 'package:sketchword/presentation/widgets/welcome_card.dart';

class Muro extends StatelessWidget {
  const Muro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 232, 243),
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //WelcomeCard(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Color(0XFF0879A6)),
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(30))),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Verdaderamente Libres?',
                            style: TextStyle(
                                color: Color(0XFF0879A6),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '3 Grandes aspectos de una verdadera libertad',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Juan 8:36',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.italic),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 207, 232, 243),
                                        borderRadius: BorderRadius.circular(
                                          25.0,
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child: Text('Evangelio')),
                                      ))),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 243, 239, 183),
                                        borderRadius: BorderRadius.circular(
                                          25.0,
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child: Text('Textual')),
                                      ))),
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: const Color(0XFF0879A6),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.post_add,
                                      color: Colors.white,
                                    )),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: const Color(0XFF0879A6),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                    )),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Color(0XFF0879A6),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}
