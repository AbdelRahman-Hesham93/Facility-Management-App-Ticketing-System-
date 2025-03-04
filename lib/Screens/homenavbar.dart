import 'package:flutter/material.dart';
import 'package:sam_app/Screens/homepagescreen.dart';
import 'package:sam_app/Screens/mycart.dart';
import 'package:sam_app/Screens/screenserv.dart';
import 'package:sam_app/Screens/screenservit.dart';
import 'package:sam_app/globalvar.dart';

class HBottomNavBar extends StatefulWidget {
  HBottomNavBar({Key? key}) : super(key: key);

  @override
  _HBottomNavBarState createState() => _HBottomNavBarState();
}

class _HBottomNavBarState extends State<HBottomNavBar> {
  int pageindex = 0;
  final myPages = [
    HomePageS(),
    const Screenservit(),
    const AllRequest(),
    const Screenserv(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPages[pageindex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: pageindex,
        onTap: (index) {
          setState(() {
            pageindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_sharp),
            label: 'Home',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.computer_sharp),
            label: 'IT',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.description_sharp),
            label: 'Requests',
            backgroundColor: mainColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apartment_sharp),
            label: 'Facility',
            backgroundColor: mainColor,
          ),
        ],
        unselectedItemColor:  Colors.white,
        selectedItemColor: const Color.fromARGB(255, 10, 27, 4),
      ),
    );
  }
}
