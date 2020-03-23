//import 'package:flutter/material.dart';
//import 'package:mygame/services/db.dart';
//import 'package:mygame/shared/bottom_nav.dart';
//import 'package:percent_indicator/percent_indicator.dart';
//import 'package:flutter/rendering.dart';
//import 'package:provider/provider.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:mygame/services/global_models.dart';
//import 'package:mygame/services/services.dart';
//
//
//class HomeScreen extends StatefulWidget {
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//
//  var data;
//  double percent;
//
//  changePercent(){
//
//    setState(() {
//      percent = 0.2;
//
//    });
//    print('I am tabbed');
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    var user = Provider.of<FirebaseUser>(context);
//
//    return FutureBuilder(
//      future: Global.topicsRef.getData(),
//      builder: (BuildContext context, AsyncSnapshot snap){
//
//        if(snap.hasData){
//          List<Topic>  topics  = snap.data;
//          return   Scaffold(
//              bottomNavigationBar: AppBottomNav(),
//              backgroundColor: Color(0xff352949),
//              body: Column(
//                mainAxisSize: MainAxisSize.min,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  SizedBox(
//                    height: MediaQuery.of(context).size.height * 0.05,
//                  ),
//
//                  //topBar
//                  Stack(
//                    children: <Widget>[
//                      Container(
//
//                        height: 140,
//                      ),
//
//
//                      Positioned(
//                        top: 32,
//                        width: MediaQuery.of(context).size.width,
//                        height: 80,
//                        child: Container(
//                          // A fixed-height child.
//                          color: const Color(0xff162841), // Yellow
//                        ),
//                      ),
//
//                      topBarItem(
//                        bottomRight: 40,
//                        topRight: 40,
//                        ptop: 32,
//                      ),
//
//                      //image of gems
//
//                      topBarItem(
//                        leftValue: MediaQuery.of(context).size.width * 0.82,
//                        bottomLeft: 40,
//                        topLeft: 40,
//                        ptop: 32,
//
//                      ),
//
//                      Gold(
//                        ptop: 49,
//                        pleft: 10,
//                        image: 'assets/gems.png',
//                        text: '6',
//                      ),
//                      Gold(
//                        ptop: 49,
//                        pleft: MediaQuery.of(context).size.width * 0.9,
//                        image: 'assets/gold.png',
//                        text: '100',
//                      ),
//
//                      Positioned(
//                        bottom: 5,
//                        top: 5,
//                        right: 5,
//                        left: 5,
//                        child: Align(
//                          alignment: Alignment.center,
//                          child: CircleAvatar(
//                            radius: 50,
//                            backgroundColor: Colors.white,
//                            child: Image.network(
//                              'https://trimtab.living-future.org/wp-content/uploads/2018/10/Circular-headshots4.png',
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  Text(
//                    user.displayName ?? 'Guest',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  SizedBox(
//                    height: MediaQuery.of(context).size.height * 0.03,
//                  ),
//                  LinearPercentIndicator(
//                    width: MediaQuery.of(context).size.width * 0.8,
//                    lineHeight: 14.0,
//                    percent: percent ?? 0.0,
//                    backgroundColor: Color(0xff121B27),
//                    progressColor: Color(0xffFFDC64),
//                    alignment: MainAxisAlignment.center,
//                  ),
//
//                  SizedBox(
//                    height: MediaQuery.of(context).size.height * 0.008,
//                  ),
//                  Text(
//                    'level 1',
//                    style: TextStyle(color: Colors.white),
//                  ),
//
//
//                  Expanded(
//                    child: ListView.builder(
//
//                        itemCount: topics.length,
//                        itemBuilder: (BuildContext context, int index) {
//                          return new SubjectContainer(topic: topics[index],);
//                        }
//
//                    ),
//                  ),
//
//
//                ],
//              )
//
//
//          );
//
//        } else {
//
//          return Text('Loading');
//        }
//
//
//      },
//
//    );
//  }
//}
//
//class Gold extends StatelessWidget {
//  Gold(
//      {this.pbottom,
//        this.pleft,
//        this.pright,
//        this.ptop,
//        this.image,
//        this.text});
//
//  final double ptop;
//  final double pbottom;
//  final double pright;
//  final double pleft;
//  final String image;
//  final String text;
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      top: ptop,
//      bottom: pbottom,
//      right: pright,
//      left: pleft,
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 30,
//            child: Image.asset(image),
//          ),
//          SizedBox(
//            height: MediaQuery.of(context).size.height * 0.008,
//          ),
//          Text(
//            text ?? '',
//            style: TextStyle(color: Colors.orange),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class topBarItem extends StatelessWidget {
//  const topBarItem(
//      {Key key,
//        this.leftValue = 0,
//        this.bottomLeft = 0,
//        this.topLeft = 0,
//        this.topRight = 0,
//        this.bottomRight = 0,
//        this.ptop})
//      : super(key: key);
//
//  final double leftValue;
//  final double topRight;
//  final double topLeft;
//  final double bottomRight;
//  final double bottomLeft;
//  final double ptop;
//
//  @override
//  Widget build(BuildContext context) {
//    return Positioned(
//      top: ptop,
//      left: leftValue,
//      child: Container(
//        height: 80,
//        width: 70,
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.only(
//            topRight: Radius.circular(topRight),
//            bottomRight: Radius.circular(bottomRight),
//            topLeft: Radius.circular(topLeft),
//            bottomLeft: Radius.circular(topLeft),
//          ),
//          color: Color(0xff0D1829),
//        ),
//      ),
//    );
//  }
//}
//
//class SubjectContainer extends StatelessWidget {
//  SubjectContainer(
//      {this.topic,this.percent = 0.5, this.image, this.resume = false, this.subjectTitle,this.change});
//
//  final String subjectTitle;
//  final String image;
//  final bool resume;
//  final double percent;
//  final Function change;
//  final Topic topic;
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.only(top: 20.0),
//      child: Container(
//        padding: EdgeInsets.only(
//          left: 20,
//          right: 10,
//        ),
//        color: Color(0xffFC5F61),
//        height: 160,
//        width: MediaQuery.of(context).size.width * 0.96,
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.only(left: 3),
//                      child: Text(
//                        topic.title ?? 'Chemistry',
//                        style: TextStyle(color: Colors.white, fontSize: 30),
//                      ),
//                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
//                    LinearPercentIndicator(
//                      animation: true,
//                      width: MediaQuery.of(context).size.width * 0.55,
//                      lineHeight: 10.0,
//                      percent: percent,
//                      backgroundColor: Color(0xff121B27),
//                      progressColor: Color(0xffFFDC64),
//                      alignment: MainAxisAlignment.center,
//                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * 0.02,
//                    ),
//                    FlatButton(
//                      child: Text(
//                        resume ? 'Resume' : 'Start',
//                        style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 20,
//                            fontWeight: FontWeight.w200),
//                      ),
//                      disabledColor: Colors.yellow,
//                      color: Colors.yellow,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: new BorderRadius.circular(18.0),
//                          side: BorderSide(color: Colors.red)),
//                      onPressed:(){change();},
//                    )
//                  ],
//                ),
//
//                SizedBox(width: 20,),
////                Image.asset(image ?? 'assets/chemistry.png'),
//                Container(
//                  height: 100,
//                  child: Image.network(
//                    image ??
//                        'https://trimtab.living-future.org/wp-content/uploads/2018/10/Circular-headshots4.png',
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
