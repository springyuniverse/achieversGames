import 'package:flutter/material.dart';
import 'package:mygame/screens/testItemBar.dart';
import 'package:mygame/shared/bottom_nav.dart';
import 'package:mygame/shared/roundned_button.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../provider/add_subject_provider.dart';
import '../services/progressBarProvider.dart';
import '../services/services.dart';
import '../shared/loader.dart';
import '../shared/progress_bar.dart';
import 'chatRoom.dart';
import 'no_subjects.dart';
import 'quiz.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';



class HomeScreen extends StatelessWidget {

//  Future<void> getEvent(){
//
//    return FirebaseInAppMessaging.instance.triggerEvent('roro');
//  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
        future: Global.subjectRef.getData(),
        builder: (BuildContext context, AsyncSnapshot snap) {

          if(snap.hasError){
            print("at home ${snap.data}");
            print(snap.error);
          }
          if(!snap.hasData){

            return LoadingScreen();

          } else {

            List<MySubject> mainSubjects = snap.data;

//            getEvent();

            print('I have home ');

            MyUserProfile profile = Provider.of<MyUserProfile>(context);

            if(profile.subjects.length <= 0){

              return NoSubjectsScreen();

            }
            return Scaffold(
              bottomNavigationBar: AppBottomNav(),
              backgroundColor: Color(0xff352949),
              body: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                          ),

                          ItemBar(),
                          SizedBox(height: 10,),
                          Text(
                            profile.name ?? 'Guest',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.03,
                          ),
                          LinearPercentIndicator(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.8,
                            lineHeight: 14.0,
                            percent: 0.0,
                            backgroundColor: Color(0xff121B27),
                            progressColor: Color(0xffFFDC64),
                            alignment: MainAxisAlignment.center,
                          ),

                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.008,
                          ),
                          Text(
                            'level 1',
                            style: TextStyle(color: Colors.white),
                          ),

                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: profile.subjects.length,
                              itemBuilder: (BuildContext ctxt, int index) {

                                MySubject sub;
                                for(MySubject subj in mainSubjects){
                                  if(subj.id   == profile.subjects[index].title){

                                    sub = subj;
                                    break;
                                  }
                                }

                                return new SubjectCard(

                                  subject: profile.subjects[index],
                                  mainSubject: sub,
                                );
                              }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
    }
    );
  }
}


class Gold extends StatelessWidget {
  Gold(
      {this.pbottom,
      this.pleft,
      this.pright,
      this.ptop,
      this.image,
      this.text});

  final double ptop;
  final double pbottom;
  final double pright;
  final double pleft;
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ptop,
      bottom: pbottom,
      right: pright,
      left: pleft,
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            child: Image.asset(image),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.008,
          ),
          Text(
            text ?? '',
            style: TextStyle(color: Colors.orange),
          ),
        ],
      ),
    );
  }
}

class topBarItem extends StatelessWidget {
  const topBarItem(
      {Key key,
        this.leftValue = 0,
        this.bottomLeft = 0,
        this.topLeft = 0,
        this.topRight = 0,
        this.bottomRight = 0,
        this.ptop,
        this.color = const Color(0xff0D1829),
        this.containerH = 80,
        this.containerW = 70



      })
      : super(key: key);

  final double leftValue;
  final double topRight;
  final double topLeft;
  final double bottomRight;
  final double bottomLeft;
  final double ptop;
  final double containerH;
  final double containerW;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ptop,
      left: leftValue,
      child: Container(
        height: containerH,
        width: containerW,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRight),
            bottomRight: Radius.circular(bottomRight),
            topLeft: Radius.circular(topLeft),
            bottomLeft: Radius.circular(topLeft),
          ),
          color: color,
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  SubjectCard(
      {this.subject, this.mainSubject,this.resume = false});

  bool resume;
  final MySubject subject;
  final MySubject mainSubject;

  //query .where(topic == quizRef)

  @override
  Widget build(BuildContext context) {
    print(subject.title);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 10,
        ),
        color: Color(0xffFC5F61),
        height: 160,
        width: MediaQuery.of(context).size.width * 0.96,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        subject.title,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
//                    LinearPercentIndicator(
//                      animation: true,
//                      width: MediaQuery.of(context).size.width * 0.55,
//                      lineHeight: 10.0,
//                      percent: percent,
//                      backgroundColor: Color(0xff121B27),
//                      progressColor: Color(0xffFFDC64),
//                      alignment: MainAxisAlignment.center,
//                    ),

                      SubjectProgress(subject: mainSubject,width: 0.6,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    FlatButton(
                      child: Text(
                        resume ? 'Resume' : 'Start',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w200),
                      ),
                      disabledColor: Colors.yellow,
                      color: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () {
                        resume = true;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => SubjectScreen(
                                  getSubject: subject,
                                )));
                      },
                    )
                  ],
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  height: 100,
                  child: Image.asset(
                    subject.img,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectScreen extends StatelessWidget {
  SubjectScreen({this.getSubject});
  final MySubject getSubject;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Document<MySubject>(path: 'Subjects/${getSubject.title}').getData(),
    builder: (BuildContext context, AsyncSnapshot snap) {



      if(snap.hasData ){

        MySubject subject = snap.data;

    return Scaffold(
          bottomNavigationBar: AppBottomNav(),
          appBar: AppBar(
            backgroundColor: Color(0xffFFDC64),
            title: Text(
              subject.title,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Color(0xff352949),
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                alignment: Alignment.center,
                                child: Hero(
                                    tag: subject.img,
                                    child: Image.asset(
                                      subject.img,
                                      fit: BoxFit.contain,
                                    )),
                                height: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${subject.myTopics.length} Topics',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              SubjectProgress(subject: subject),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RoundedButton(title: 'Chat Room',onpressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChatRoom(
                                                chatRoom: subject.title,),)
                                    );
                                  }
                                  ),

                                  RoundedButton(title: 'I need a teacher',onpressed: (){},),


                                ],
                              )


                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.30,
                          color:  Color(0xffFC5F61),

                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TopicsCard(topics: subject.myTopics,subjectImage: subject.img,subjectName: subject.id,),
                      ],
                    )));
          }));} else {
        return LoadingScreen();
      }

    },
    );
  }
}


class TopicsCard extends StatelessWidget {
  TopicsCard({this.topics,this.subjectImage,this.subjectName});

  final List<MyTopics> topics;
  final String subjectImage;
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(


        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: topics.length,
        itemBuilder: (BuildContext ctxt, int index) {
      return Column(
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      QuizSetsScreen(topic: topics[index],subjectImage: subjectImage,subjectName: subjectName,),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              overflow: Overflow.clip,
              children: <Widget>[


                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width * 0.90,
                  color: Color(0xffFFE27C),
                ),

                topBarItem(
                  bottomRight: 40,
                  topRight: 40,
                  ptop: 15,
                  leftValue: -10,
                  color: Color(0xffFC5F61),
                ),

                Positioned(

                  child: Text('${index+1}',style: TextStyle(color: Colors.white,fontSize: 30),),
                  top: 35,
                  left: 13,
                ),

//              Positioned(
//                child: Text(topics[index].title,style: TextStyle(color: Color(0xff121B27),fontSize: 25,fontWeight: FontWeight.w600),),
//                top: 20,
//                left: 70,
//              ),

                Positioned(
                  top: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 230,
                        child:Center(child: Text(topics[index].title,style: TextStyle(color: Color(0xff121B27),fontSize: 23,fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                      ),

                      SizedBox(height: 3,),
                      TopicProgress(topic: topics[index],subject: subjectName,color: Color(0xffFC5F61),width: 0.55,showText: false,),

                      SizedBox(height: 5,),
                      Text('2/${topics[index].quizSets.length} Sets')



                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      );
        },




    );
  }
}

class QuizSetsScreen extends StatelessWidget {
  final MyTopics topic;
  final String subjectImage;
  final String subjectName;
  bool isTrue = false;


  QuizSetsScreen({this.topic,this.subjectImage,this.subjectName});
  @override


  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.quizRef.getMyData('topic',topic.id),
      builder: (BuildContext context, AsyncSnapshot snap){

        if(snap.hasData){

          List<Quiz> qu  = snap.data;
          print(qu);

         return  Scaffold(
              key: Global.scaffoldKey,
              bottomNavigationBar: AppBottomNav(),
              appBar: AppBar(
                backgroundColor: Color(0xffFFDC64),
                title: Text(
                  topic.title ?? 'hello',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              backgroundColor: Color(0xff352949),
              body: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Column(

                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      subjectImage,
                                      fit: BoxFit.contain,
                                    ),
                                    height: 130,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  TopicProgress(topic: topic,subject: subjectName,color: Color(0xffFFDC64),),
                                  SizedBox(
                                    height: 10,
                                  ),

                                ],
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              color:  Color(0xffFC5F61),

                            ),
                            SizedBox(
                              height: 20,
                            ),

                            QuizSets2(quizzes: qu,topic: topic,subjectName: subjectName,),
                          ],
                        )));
              })


          );

        } else  {

          return LoadingScreen();
        }
      },
    );


  }
}




class LoginButton extends StatelessWidget {


  final String text;
  final Color color;
  final String subjectID;

  const LoginButton({Key key, this.text, this.color,this.subjectID})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,

      child: MaterialButton(
        color: color,
        child: Text(text, style: TextStyle(color: Colors.white),),
        onPressed: ()  {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ChatRoom(chatRoom: subjectID,),
            ),
          );
        },
      ),
    );

  }

}


class QuizSets2 extends StatelessWidget {

  final List<Quiz> quizzes;
  final String subjectName;
  final MyTopics topic;

  QuizSets2({Key key, this.quizzes,this.subjectName,this.topic});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
     itemCount: quizzes.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,mainAxisSpacing: 10),

      itemBuilder: (BuildContext ctxt, int index){
        print('heeeey' + subjectName);

        return Padding(
         padding: const EdgeInsets.all(8.0),
         child: InkWell(
           onTap: () {


             print(quizzes[index].id);
             Navigator.of(context).push(
               MaterialPageRoute(
                 builder: (BuildContext context) =>
                     QuizScreen(quizId: quizzes[index].id),
               ),
             );
           },
           child: Container(
             color: Color(0xffFFE27C),

             child: Column(
                children: <Widget>[

                  SizedBox(height: 30,),
                  Text('Quiz Set ${index+1}',style: TextStyle(color: Color(0xff121B27),fontSize: 30,fontWeight: FontWeight.w600 ),),
                  Text('Difficulty ${quizzes[index].difficulty}' ),
                  SizedBox(height: 10,),
                  QuizBadge(subject:subjectName ,topic: topic, quizId: quizzes[index].id,),




                ],


             ),
           ),
         ),
       );
      }
    );
  }
}
