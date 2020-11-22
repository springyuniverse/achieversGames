//import 'package:flutter/material.dart';
//
//
//class topBarItem extends StatelessWidget {
//  const topBarItem(
//      {Key key,
//        this.leftValue = 0,
//        this.bottomLeft = 0,
//        this.topLeft = 0,
//        this.topRight = 0,
//        this.bottomRight = 0,
//        this.ptop,
//        this.color = const Color(0xff0D1829),
//        this.containerH = 80,
//        this.containerW = 70
//
//
//
//      })
//      : super(key: key);
//
//  final double leftValue;
//  final double topRight;
//  final double topLeft;
//  final double bottomRight;
//  final double bottomLeft;
//  final double ptop;
//  final double containerH;
//  final double containerW;
//
//  final Color color;
//
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      top: ptop,
//      left: leftValue,
//      child: Container(
//        height: containerH,
//        width: containerW,
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.only(
//            topRight: Radius.circular(topRight),
//            bottomRight: Radius.circular(bottomRight),
//            topLeft: Radius.circular(topLeft),
//            bottomLeft: Radius.circular(topLeft),
//          ),
//          color: color,
//        ),
//      ),
//    );
//  }
//}
