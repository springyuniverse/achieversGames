//import 'package:flutter/material.dart';
//class Gold extends StatelessWidget {
//  Gold(
//      {this.pbottom,
//        this.pleft,
//        this.pright,
//        this.ptop,
//        this.image,
//        this.text});
//
//  final double ptop;
//  final double pbottom;
//  final double pright;
//  final double pleft;
//  final String image;
//  final String text;
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      top: ptop,
//      bottom: pbottom,
//      right: pright,
//      left: pleft,
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 30,
//            child: Image.asset(image),
//          ),
//          SizedBox(
//            height: MediaQuery.of(context).size.height * 0.008,
//          ),
//          Text(
//            text ?? '',
//            style: TextStyle(color: Colors.orange),
//          ),
//        ],
//      ),
//    );
//  }
//}