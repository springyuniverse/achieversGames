import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.graduationCap, size: 20),
            title: Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plusCircle, size: 20),
            title: Text('Add a Subject')),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCircle, size: 20),
            title: Text('Profile')),
      ].toList(),
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/homeScreen', (Route<dynamic> route) => false);
            break;
          case 1:
            Navigator.pushNamed(context, '/addsubject');
            break;
          case 2:
            Navigator.pushNamed(context, '/userprofile');
            break;
        }
      },
    );
  }
}