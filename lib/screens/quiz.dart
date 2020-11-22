import 'package:flutter/material.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


// Shared Data
class QuizState with ChangeNotifier {
  double _progress = 0;
  Option _selected;

  final PageController controller = PageController();

  get progress => _progress;
  get selected => _selected;

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(Option newValue) {
    _selected = newValue;
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}

class QuizScreen extends StatelessWidget {
  QuizScreen({this.quizId});
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => QuizState(),
      child: FutureBuilder(
        future: Document<Quiz>(path: 'quizzes/$quizId').getData(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          var state = Provider.of<QuizState>(context);

          if (!snap.hasData || snap.hasError) {
            return LoadingScreen();
          } else {
            Quiz quiz = snap.data;
            return Scaffold(
              backgroundColor: Color(0xff352949),
              appBar: AppBar(
                backgroundColor: Color(0xffFC5F61),
                title: AnimatedProgressbar(value: state.progress),
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.times),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) =>
                    state.progress = (idx / (quiz.questions.length + 1)),
                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage(quiz: quiz);
                  } else if (idx == quiz.questions.length + 1) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[idx - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  final PageController controller;
  StartPage({this.quiz, this.controller});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: TextStyle(color: Colors.white)),
          Text(quiz.description,style: TextStyle(color: Colors.white)),
          Image.asset('assets/startquiz.gif',),

          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: state.nextPage,
                label: Text('Start Quiz!'),
                icon: Icon(Icons.poll),
                color: Colors.green,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  CongratsPage({this.quiz});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            style:TextStyle(color:Colors.white),
            textAlign: TextAlign.center,
          ),
          Divider(),
          Image.asset('assets/congrats.gif'),
          Divider(),
          FlatButton.icon(
            color: Colors.redAccent,
            icon: Icon(FontAwesomeIcons.check),
            label: Text(' Mark Complete!'),
            onPressed: () {

              if(Provider.of<Report>(context).subjects[quiz.subjectID] == null){

                _updateUserReport(quiz,user);

              } else if (Provider.of<Report>(context).subjects[quiz.subjectID][quiz.topic] == null){

                _updateUserReport(quiz,user);


              } else if(!Provider.of<Report>(context).subjects[quiz?.subjectID][quiz?.topic].contains(quiz?.id)){

                  _updateUserReport(quiz,user);

                }


              Navigator.pop(context);

              AwardsProvider ap = AwardsProvider(subjectName: quiz.subjectID,topicID: quiz.topic);

              ap.shoWDialog();

            },
          )
        ],
      ),
    );
  }

  /// Database write to update report doc when complete
  Future<void> _updateUserReport(Quiz quiz, User user) {

    return Global.reportRef.upsert(
      ({
        'total': FieldValue.increment(1),
        'subjects': {
          '${quiz.subjectID}': {

            '${quiz.topic}': FieldValue.arrayUnion([quiz.id]),
            'total': FieldValue.increment(1)
          }
        }
      }),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  QuestionPage({this.question});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,

        child: ListView(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[


                          Text(question.text,style: TextStyle(color: Colors.white,fontSize: 20),),


                          SizedBox(
                            height: 30,
                          ),
                          Image.network(question.image)










                  ],
                )


              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: question.options.map((opt) {
                  return Container(
                    height: 90,
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.black26,
                    child: InkWell(
                      onTap: () {
                        state.selected = opt;
                        _bottomSheet(context, opt);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(
                                state.selected == opt
                                    ? FontAwesomeIcons.checkCircle
                                : FontAwesomeIcons.circle,
                                color: Colors.white,
                                size: 30),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text(
                                  opt.value,
                                  style: TextStyle(color: Colors.white)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Bottom sheet shown when Question is answered
  _bottomSheet(BuildContext context, Option opt) {
    bool correct = opt.correct;
    var state = Provider.of<QuizState>(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              FlatButton(
                color: correct ? Colors.green : Colors.red,
                child: Text(
                  correct ? 'Onward!' : 'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (correct) {
                    state.nextPage();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
