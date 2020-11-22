import 'services.dart';
import 'package:flutter/material.dart';

class Global {



  static final kMessageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    ),
  );

  static final  kSendButtonTextStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );


  static final kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );
  // App Data
  static final String title = 'Fireship';

  // Services
  static final GlobalKey _scaffoldKey = GlobalKey();

  static  GlobalKey get scaffoldKey => _scaffoldKey;

  // Data Models
  static final Map models = {
    Topic: (data) => Topic.fromMap(data),
    Quiz: (data) => Quiz.fromMap(data),
    Report: (data) => Report.fromMap(data),
    MySubject: (data) => MySubject.fromMap(data),
    MyUserProfile: (data) => MyUserProfile.fromMap(data),


  };

  // Firestore References for Writes
  // just for making things easier
  static final Collection<Quiz> quizRef = Collection<Quiz>(path: 'quizzes');
  static final UserData<Report> reportRef = UserData<Report>(collection: 'reports');
  static final UserData<Report> userProfile = UserData<Report>(collection: 'users');
  static final Collection<MySubject> subjectRef = Collection<MySubject>(path: 'Subjects');
  static final UserData<MyUserProfile> usersRef = UserData<MyUserProfile>(collection: 'users');
  static final Collection<ChatMessage> chatMessageRef = Collection<ChatMessage>(path: 'messages');





//  my implementation
//  static final Collection<MySubject> subjectRef = Collection<MySubject>(path: 'Subjects');





}
