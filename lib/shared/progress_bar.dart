import 'package:flutter/material.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loader.dart';


class AnimatedProgressbar extends StatelessWidget {
  final double value;
  final double height;

  AnimatedProgressbar({Key key, @required this.value, this.height = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        return Container(
          padding: EdgeInsets.all(10),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floor(value),
                decoration: BoxDecoration(
                  color: _colorGen(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Always round negative or NaNs to min value
  _floor(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  _colorGen(double value) {
    int rbg = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }
}

class QuizBadge extends StatelessWidget {
  final String quizId;
  final MyTopics topic;
  final String subject;

  const QuizBadge({Key key, this.subject,this.quizId, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Report report = Provider.of<Report>(context);

    print(subject);
    print(report.subjects[subject].toString() + ' hooooo');
    if (report != null) {
      List completed;
      try{
         completed = report.subjects[subject][topic.id];

      } catch (e){
        completed = null;
        print('no way');
      }
      if (completed != null && completed.contains(quizId)) {
        return  CircleAvatar(child:  Icon(FontAwesomeIcons.check,color: Color(0xff121B27),),radius: 30,backgroundColor:Color(0xffFC5F61) ,);

    } else {

        return  CircleAvatar(child:  Icon(FontAwesomeIcons.arrowRight,color: Color(0xff121B27),),radius: 30,backgroundColor:Color(0xffFC5F61) ,);

    }
    } else {
      return Icon(FontAwesomeIcons.circle, color: Colors.grey);
    }
  }
}

final _store = Firestore.instance;

class TopicProgress extends StatelessWidget {
  final MyTopics topic;
  final String subject;
  final Color color;
  final double width;
  final bool showText;
  List<Quiz> quizzes;
  int quizzesLength;
  int completedQuizzes;



  TopicProgress({Key key, this.showText = true,this.color,this.topic,this.subject,this.width = 0.8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _store.collection("quizzes").where("topic",isEqualTo: "${topic.id}").snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData) {

           this.quizzesLength = snapshot.data.documents.length;
           if (completedQuizzes == null){
             completedQuizzes = 0;
           }


          return Column(
            children: [
//        _progressCount(report, topic),

              LinearPercentIndicator(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * width,
                lineHeight: 14.0,
                percent: calculateProgress(topic, report) <= 1
                    ? calculateProgress(topic, report)
                    : 0,
                backgroundColor: Color(0xff121B27),
                progressColor: color,
                alignment: MainAxisAlignment.center,
              ),
              SizedBox(height: 15,),


              Text( showText ?  '$completedQuizzes/$quizzesLength Quizzes' : '',style: TextStyle(color: Colors.white),),

            ],
          );
        } else {
          return LoadingScreen();
        }
      }
    );
  }




//  Widget _progressCount(Report report, MyTopics topic) {
//    if (report.subjects != null && topic != null && showText) {
//      return Padding(
//        padding: const EdgeInsets.only(left: 8),
//        child: Text(
//          '${report?.subjects[subject][topic.id] != null ? report?.subjects[subject][topic.id].length : 0} / ${topic?.quizSets?.length ?? 0}',
//          style: TextStyle(fontSize: 14, color: Colors.white),
//        ),
//      );
//    } else {
//      return Container();
//    }
//  }

  double calculateProgress(MyTopics topic, Report report, ) {


    try {

      int completedQuizzes;
      if(report.subjects == null){

         completedQuizzes = 0;

      } else if  (report.subjects[subject][topic.id] == null){

        completedQuizzes = 0;
      } else {

        completedQuizzes = report.subjects[subject][topic.id].length;

      }

      this.completedQuizzes = completedQuizzes;
      return completedQuizzes  / quizzesLength ?? 0 ;
    } catch (err) {
      return 0.0;
    }
  }
}


class SubjectProgress extends StatelessWidget {

  final Color color;
  final double width;
  final MySubject subject;
   SubjectProgress({Key key,this.subject,this.color,this.width = 0.8}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * width,
      lineHeight: 14.0,
      percent:  calculateProgress(report) <= 1 ? calculateProgress(report): 0 ,
      backgroundColor: Color(0xff121B27),
      progressColor: Colors.yellow,
      alignment: MainAxisAlignment.center,
    );


  }




  double calculateProgress(Report report) {


    try {
      int totalQuizzes = subject.numOfQuizzes;
      int completedQuizzes = report.subjects[subject.id]['total'] ?? 0;
      print('hello' + subject.title);
      return completedQuizzes / totalQuizzes ?? 0;
    } catch (err) {
      print('error' + subject.title);

      return 0.0;
    }
  }
}
