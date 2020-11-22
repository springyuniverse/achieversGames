import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mygame/services/auth.dart';
import 'package:mygame/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  AuthService auth = AuthService();
  @override
  void initState() {
    super.initState();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff352949),

      body: Center(
        child: Column(



          crossAxisAlignment:CrossAxisAlignment.center,

          children: <Widget>[

            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),

            Text('Achievers ',style: TextStyle(color:Color(0xffFFDC64),fontSize: 70,fontWeight: FontWeight.w600),),
            Text('Hunger Games ',style: TextStyle(color:Color(0xffFFDC64),fontSize: 30,fontWeight: FontWeight.w200),),
            SizedBox(height: 50,),

            Image.asset('assets/swords.png',),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            LoginButton(text: 'Login with Google', color: Colors.deepOrange,loginMethod: auth.googleSignIn,)






          ],




        ),
      ),
    );
  }
}



class LoginButton extends StatelessWidget {


  final String text;
  final Color color;
  final Function loginMethod;

  const LoginButton({Key key, this.text, this.color, this.loginMethod})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,

      child: MaterialButton(
        color: color,
        child: Text(text, style: TextStyle(color: Colors.black),),
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/homeScreen');

          }
        },
      ),
    );

  }

}
