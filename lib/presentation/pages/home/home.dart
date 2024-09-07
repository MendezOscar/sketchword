import 'package:flutter/material.dart';
import 'package:sketchword/presentation/pages/home/my_sketches.dart';
import 'package:sketchword/presentation/pages/home/profile.dart';
import 'package:sketchword/presentation/widgets/my_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    const MySketches(),
    // const Muro(),
    // Container(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: getAppBar(_selectedIndex),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0XFF0879A6), spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: const Color(0XFF0879A6),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Color(0XFF0879A6),
                  activeIcon: Icon(Icons.edit),
                  icon: Icon(Icons.edit_outlined),
                  label: 'Bosquejos',
                ),
                // BottomNavigationBarItem(
                //   backgroundColor: Color(0XFF0879A6),
                //   activeIcon: Icon(Icons.newspaper),
                //   icon: Icon(Icons.newspaper_outlined),
                //   label: 'Muro',
                // ),
                // BottomNavigationBarItem(
                //   backgroundColor: Color(0XFF0879A6),
                //   activeIcon: Icon(Icons.star),
                //   icon: Icon(Icons.star_rounded),
                //   label: 'Tips',
                // ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0XFF0879A6),
                  activeIcon: Icon(Icons.person),
                  icon: Icon(Icons.person_2_outlined),
                  label: 'Perfil',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  dynamic getAppBar(int selectedIndex) {
    if (selectedIndex == 0) {
      return const MyAppBar(
        title: 'Mis Bosquejos',
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      );
    } else if (selectedIndex == 1) {
      return const MyAppBar(
        title: 'Perfil',
        icon: Icon(
          Icons.newspaper,
          color: Colors.white,
        ),
      );
    } else if (selectedIndex == 2) {
      return const MyAppBar(
        title: 'Tips',
        icon: Icon(Icons.star),
      );
    } else if (selectedIndex == 3) {
      return const MyAppBar(
        title: 'Perfil',
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
      );
    } else {
      return const MyAppBar(
        title: '',
        icon: Icon(Icons.edit),
      );
    }
  }
}
