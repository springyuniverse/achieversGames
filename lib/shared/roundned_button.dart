import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({this.title,this.onpressed});
  final String title;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xff352949),

        ),
        child: Text(title,style: TextStyle(color: Colors.white),),
      ),
      onPressed: onpressed,
    );
  }
}
