import 'package:flutter/material.dart';
import 'package:mygame/screens/add_subjects.dart';
import 'package:mygame/screens/home_screen.dart';
import 'package:mygame/screens/testItemBar.dart';
import 'package:mygame/screens/user_profile.dart';
import 'provider/add_subject_provider.dart';
import 'screens/login_screen.dart';
import 'screens/chatRoom.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/no_subjects.dart';
import 'services/auth.dart';
import 'services/services.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

-


        StreamProvider<MyUserProfile>.value(value: Global.usersRef.documentStream,),

        StreamProvider<User>.value(value: AuthService().user),
        StreamProvider<Report>.value(value: Global.reportRef.documentStream),




      ],
      child: MaterialApp(

          debugShowCheckedModeBanner: false,
          navigatorObservers: [
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {

          '/': (context) => LoginScreen(),
          '/userprofile': (context) => UserProfile(),
          '/homeScreen': (context) =>  HomeScreen(),
          '/addsubject':(context) => AddSubject(),
          '/chatRoom':(context) => ChatRoom(),


        },
      ),
    );
  }
}

