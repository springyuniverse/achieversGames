import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/services.dart';
import '../shared/loader.dart';




class UserProfile extends StatelessWidget {
  final AuthService auth  = AuthService();
  @override
  Widget build(BuildContext context) {

    var user = Provider.of<User>(context);

    return FutureBuilder(
        future: Global.usersRef.getDocument(),
        builder: (BuildContext context, AsyncSnapshot snap){

          if(!snap.hasData || snap.hasError){

            return LoadingScreen();

          } else {

            MyUserProfile userProf = snap.data;
            return Scaffold(
                appBar: AppBar(

                  backgroundColor: Color(0xffFFDC64),
                  title: Text('My Profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700) ),
                ),

                backgroundColor:  Color(0xff352949),
                body: Center(
                  child: Column(



                    crossAxisAlignment:CrossAxisAlignment.center,

                    children: <Widget>[

                      SizedBox(height: 150,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Text('Welcome, ',style: TextStyle(color: Color(0xffFFDC64),fontWeight: FontWeight.w700) ),
                          Text( userProf.name ?? 'hello',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400) ),
                          SizedBox(height: 50,),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(userProf.img)
                            ,
                          )

                        ],
                      ),

                      SizedBox(height: 50,),

                      RaisedButton(

                        color: Color(0xffFFDC64),
                        disabledColor: Color(0xffFFDC64) ,
                        child: Text('Logout',style: TextStyle(color: Colors.black),),
                        onPressed: () async {
                          await auth.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil('/',(route) => false);

                        },
                      )



                    ],



                  ),
                )

            );
          }


        }




    );
  }
}
