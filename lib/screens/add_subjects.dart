import 'package:flutter/material.dart';
import 'package:mygame/services/models.dart';
import 'package:mygame/shared/bottom_nav.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../provider/add_subject_provider.dart';
import '../shared/loader.dart';
import 'home_screen.dart';
import 'package:mygame/services/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';





class AddSubject extends StatelessWidget {


  var data;
  double percent = 0;
  List<Quiz> quizzes;
  List<MySubject> selectedSubjects;


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var profile = Provider.of<MyUserProfile>(context);


    return FutureBuilder(
      future: Global.subjectRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          print('Iam in add subject ');
          List<MySubject> subjects = snap.data;
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
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        //topBar
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 140,
                            ),

                            Positioned(
                              top: 32,
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Container(
                                // A fixed-height child.
                                color: const Color(0xff162841), // Yellow
                              ),
                            ),

                            topBarItem(
                              bottomRight: 40,
                              topRight: 40,
                              ptop: 32,
                            ),

                            //image of gems

                            topBarItem(
                              leftValue:
                              MediaQuery.of(context).size.width * 0.82,
                              bottomLeft: 40,
                              topLeft: 40,
                              ptop: 32,
                            ),

                            Gold(
                              ptop: 49,
                              pleft: 10,
                              image: 'assets/gems.png',
                              text: profile.gems.toString(),
                            ),
                            Gold(
                              ptop: 49,
                              pleft: MediaQuery.of(context).size.width * 0.9,
                              image: 'assets/gold.png',
                              text:  profile.gold.toString(),
                            ),

                            Positioned(
                              bottom: 5,
                              top: 5,
                              right: 5,
                              left: 5,
                              child: Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: Image.network(
                                    'https://trimtab.living-future.org/wp-content/uploads/2018/10/Circular-headshots4.png',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          user.displayName ?? 'Guest',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width * 0.8,
                          lineHeight: 14.0,
                          percent: percent ?? 0.0,
                          backgroundColor: Color(0xff121B27),
                          progressColor: Color(0xffFFDC64),
                          alignment: MainAxisAlignment.center,
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.008,
                        ),
                        Text(
                          'level 1',
                          style: TextStyle(color: Colors.white),
                        ),

                        SubjectsCard(subject: subjects,profile:profile,)
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}





class SubjectsCard extends StatelessWidget {
  SubjectsCard(
      {this.profile,this.subject, this.percent = 0.5, this.resume = false,});

  final bool resume;
  final double percent;
  final List<MySubject> subject;
  final MyUserProfile profile;

  //query .where(topic == quizRef)

  @override
  Widget build(BuildContext context) {
    return ListView.builder(


      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: subject.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Column(
          children: <Widget>[
            InkWell(
              onTap: (){

              },
              child: Stack(
                alignment: Alignment.topLeft,
                overflow: Overflow.clip,
                children: <Widget>[


                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.95,
                    color: Color(0xffFFE27C),
                  ),

                  topBarItem(
                    bottomRight: 40,
                    topRight: 40,
                    ptop: 70,
                    leftValue: 0,
                    color: Color(0xff182B44),
                    containerH: 40,
                    containerW: 90,
                  ),

                  Positioned(

                    child: Text('2',style: TextStyle(color: Colors.white,fontSize: 25),),
                    top: 74,
                    left: 30,
                  ),

//              Positioned(
//                child: Text(topics[index].title,style: TextStyle(color: Color(0xff121B27),fontSize: 25,fontWeight: FontWeight.w600),),
//                top: 20,
//                left: 70,
//              ),

                
                  Positioned(

                    right:10 ,
                    top: 12,
                    child: Image.asset(subject[index].img,width: 90,),
                  ),

                  Gold(
                    ptop: 75,
                    pleft: 50,
                    image: 'assets/gems.png',
                  ),
                  Positioned(


                    top: 70,
                    left: 130,

                    child: FlatButton(
                      child: Text('Add',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () {

                        bool isNewSubject = true;

                        for(MySubject sub in profile.subjects) {
                          if (sub.title == subject[index].title) {
                            isNewSubject = false;

                              AwesomeDialog(context: context,
                                dialogType: DialogType.WARNING,
                                animType: AnimType.BOTTOMSLIDE,
                                tittle: 'You  already added this subject',
                                desc: '',
                                btnOkOnPress: () {}).show();
                            break;
                          }

                        }


                        if(profile.gems < 2 && isNewSubject){

                                AwesomeDialog(context: context,
                                dialogType: DialogType.WARNING,
                                animType: AnimType.BOTTOMSLIDE,
                                tittle: 'No Enough Gems',
                                desc: 'Ops it appears that you run out of Gems, want get more?',
                                btnCancelOnPress: () {},
                                btnOkText: 'Absloutly',
                                btnOkOnPress: () {}).show();

                        }



                        if(isNewSubject && profile.gems >= 2) {


                        Provider.of<MyUserProfile>(context).addSubject(subject[index]);

                          AwesomeDialog(context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.BOTTOMSLIDE,
                              tittle: 'Subject Added  Successfully',
                              desc: 'Ready to challenge yourself?',
                              btnOkText: 'Yes! Take me there',
                              btnOkOnPress: () {

                                Navigator.pushNamed(context, '/homeScreen');


                              }).show();


                        }


                      },
                    )


                  ),
                  
                  Positioned(
                    top: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(subject[index].title,style: TextStyle(color: Color(0xff121B27),fontSize: 23,fontWeight: FontWeight.w300),),

                        ],
                      ),
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

  Future<void> _updateUserReport() {

    return Global.usersRef.upsert(
      ({
        'gold': FieldValue.increment(1),

      }),
    );
  }
}