//import 'package:flutter/material.dart';
//import 'package:mygame/screens/home_screen.dart';
//
//class TopBarItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Container(
//          height: 140,
//        ),
//
//        Positioned(
//          top: 32,
//          width: MediaQuery
//              .of(context)
//              .size
//              .width,
//          height: 80,
//          child: Container(
//            // A fixed-height child.
//            color: const Color(0xff162841), // Yellow
//          ),
//        ),
//
//        topBarItem(
//          bottomRight: 40,
//          topRight: 40,
//          ptop: 32,
//        ),
//
//        //image of gems
//
//        topBarItem(
//          leftValue:
//          MediaQuery
//              .of(context)
//              .size
//              .width * 0.83,
//          bottomLeft: 40,
//          topLeft: 40,
//          ptop: 32,
//        ),
//
//        Gold(
//          ptop: 49,
//          pleft: 10,
//          image: 'assets/gems.png',
//          text: profile.gems.toString(),
//        ),
//        Gold(
//          ptop: 49,
//          pleft: MediaQuery
//              .of(context)
//              .size
//              .width * 0.9,
//          image: 'assets/gold.png',
//          text: profile.gold.toString(),
//        ),
//
//        Positioned(
//          bottom: 5,
//          top: 5,
//          right: 5,
//          left: 5,
//          child: Align(
//            alignment: Alignment.center,
//            child: CircleAvatar(
//                radius: 50,
//                backgroundColor: Colors.white,
//                backgroundImage: NetworkImage(profile.img)
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
