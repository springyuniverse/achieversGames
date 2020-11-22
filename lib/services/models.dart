//// Embedded Maps


import 'package:meta/meta.dart';
import 'global_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Option {
  String value;
  String detail;
  bool correct;

  Option({ this.correct, this.value, this.detail });
  Option.fromMap(Map data) {
    value = data['value'];
    detail = data['detail'] ?? '';
    correct = data['correct'];
  }
}


class Question {
  String text;
  List<Option> options;
  String image;
  Question({ this.options, this.text ,this.image});

  Question.fromMap(Map data) {
    text = data['text'] ?? '';
    image = data['image'] ?? '';
    options = (data['options'] as List ?? []).map((v) => Option.fromMap(v)).toList();
  }
}

///// Database Collections

class Quiz {
  String id;
  String title;
  String description;
  String subjectID;
  String video;
  String topic;
  String difficulty;
  List<Question> questions;

  Quiz({ this.title, this.questions, this.video, this.description, this.id, this.topic,this.subjectID,this.difficulty});

  factory Quiz.fromMap(Map data) {
    return Quiz(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        topic: data['topic'] ?? '',
        description: data['description'] ?? '',
        video: data['video'] ?? '',
        subjectID: data['subjectID'] ?? '',
        difficulty: data['difficulty'] ?? '',
        questions: (data['questions'] as List ?? []).map((v) => Question.fromMap(v)).toList()
    );
  }

}


class Topic {
  final String id;
  final String title;
  final  String description;
  final String img;
  final List<Quiz> quizzes;

  Topic({ this.id, this.title, this.description, this.img, this.quizzes});

  factory Topic.fromMap(Map data) {
    return Topic(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.png',
      quizzes:  (data['quizzes'] as List ?? []).map((v) => Quiz.fromMap(v)).toList(),
    );
  }

}



class Report {
  String uid;
  int total;
  dynamic topics;
  dynamic subjects;
  final List<Awards> awards;



  Report({ this.uid, this.topics, this.total,this.subjects,this.awards });

  factory Report.fromMap(Map data) {
    return Report(
      uid: data['uid'],
      total: data['total'] ?? 0,
      topics: data['topics'] ?? {},
      subjects: data['subjects'] ?? {},
      awards:  (data['awards'] as List ?? []).map((v) => Awards.fromMap(v)).toList(),

    );
  }

}




//my implementation
class ChatMessage {

  final String content;
  final String sender;
  final DateTime createdAt;
  ChatMessage({this.content,this.createdAt,this.sender});

  factory ChatMessage.fromMap(Map data) {
    return ChatMessage(
      content: data['content'] ?? '',
      sender: data['sender'] ?? '',
      createdAt: data['createdAt'] ?? DateTime.now(),
    );
  }
}



class MySubject {
  final String id;
  final String title;
  final  String description;
  final String img;
  final int numOfQuizzes;

  final List<MyTopics> myTopics;

  MySubject({ this.id, this.title, this.description, this.img, this.myTopics,this.numOfQuizzes});

  factory MySubject.fromMap(Map data) {
    return MySubject(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      img: data['img'] ?? 'default.png',
      numOfQuizzes: data['numOfQuizzes'] ?? 0,
      myTopics:  (data['topics'] as List ?? []).map((v) => MyTopics.fromMap(v)).toList(),
    );
  }

}



class MyUserProfile {
  final String uid;
  final int score;
  final  String grade;
  final  String name;
  final  String email;
  final String img;
  final int gold;
   int gems;
  final List<Awards> awards;
  final List<MySubject> subjects;

  MyUserProfile({ this.gold,this.gems,this.awards,this.email,this.name,this.uid, this.score, this.grade, this.img,this.subjects});

  factory MyUserProfile.fromMap(Map data) {
    return MyUserProfile(
      name: data['username'] ?? '',
      uid: data['uid'] ?? '',
      gold: data['gold'] ?? 0,
      gems: data['gems'] ?? 0,
      score: data['score'] ?? 0,
      grade: data['grade'] ?? '',
      img: data['img'] ?? 'default.png',
      subjects:  (data['subjects'] as List ?? [ ]).map((v) => MySubject.fromMap(v)).toList(),
      awards:  (data['awards'] as List ?? []).map((v) => Awards.fromMap(v)).toList(),

    );
  }


  addSubject(MySubject subject){

    if (this.gems >= 2) {

      subjects.add(subject);

      Global.userProfile.upsert(
        ({
          'gems': FieldValue.increment(-2),

          'subjects': FieldValue.arrayUnion([

            {
              'title': subject.title,
              'img': subject.img,
              'description': subject.description,


            }
          ])
        }),
      );


//



    }


  }

}



class Awards {

  final  String name;
  final String img;
  Awards({ this.name, this.img});

  factory Awards.fromMap(Map data) {
    return Awards(
      name: data['username'] ?? '',
      img: data['img'] ?? 'default.png',
    );
  }

}



class MyTopics {
  String id;
  String title;
  String description;
  String img;
  List<QuizSets> quizSets;

  MyTopics({ this.title, this.quizSets, this.description, this.id,this.img});

  factory MyTopics.fromMap(Map data) {
    return MyTopics(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        img: data['img'] ?? '',

        quizSets: (data['quizsets'] as List ?? []).map((v) => QuizSets.fromMap(v)).toList()
    );
  }

}

class QuizSets{

  final String id;
  final String title;
  final String difficulty;
  QuizSets({this.title,this.id,this.difficulty});


  factory QuizSets.fromMap(Map data) {
    return QuizSets(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        difficulty: data['difficulty'] ?? '',

    );
  }
}




// write to database



class Replies {

  final String title;
  final String coordinates;

  Replies({
    @required this.title,
    @required this.coordinates,
  });

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'coordinates': coordinates,
      };

}




