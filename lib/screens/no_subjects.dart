import 'package:flutter/material.dart';
import 'package:mygame/shared/bottom_nav.dart';
import 'package:mygame/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mygame/services/global_models.dart';
import 'package:mygame/services/services.dart';
import '../provider/add_subject_provider.dart';
import 'add_subjects.dart';





class NoSubjectsScreen extends StatelessWidget {

  NoSubjectsScreen();

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<MyUserProfile>(context);
    var user = Provider.of<User>(context);
    if(profile != null){
    List<MySubject> subjects = profile.subjects;}
    return  Scaffold(
        bottomNavigationBar: AppBottomNav(),
        backgroundColor: Color(0xff352949),
        body:  Column(
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
                          text: profile.gold.toString(),
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
                      percent:  0.0,
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

                    SizedBox(height: 40,),
                    Image.asset('noSubjects.png',width: 300,),

                    SizedBox(height: 20,),
                    Text('You didn’t add any subjects yet',style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(height: 20,),
                    LoginButton(text: 'Add Subject', color: Colors.yellow,profile: profile,)



                  ]
    )
    );


}
}


class LoginButton extends StatelessWidget {


  final String text;
  final Color color;
  final MyUserProfile profile;


   LoginButton({Key key, this.text, this.color,this.profile})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,

      child: MaterialButton(
        color: color,
        child: Text(text, style: TextStyle(color: Colors.black),),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddSubject(

              )));
        },
      ),
    );

  }

}
